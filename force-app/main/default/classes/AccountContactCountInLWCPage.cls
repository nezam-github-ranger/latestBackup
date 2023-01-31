public class AccountContactCountInLWCPage {
    
    public AccountContactCountInLWCPage(){
        //accountContactModelList = new List<AccountContactModel>();
    	//fetchContactCount();    
    }
    
    @AuraEnabled
    public static List<Contact> getSomeContact(){
        return [SELECT Id, Name, Email FROM Contact LIMIT 10];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<AccountContactModel> fetchContactCount(){
        List<AccountContactModel> accountContactModelList = new List<AccountContactModel>();
        List<Account> accounts = getAccounts();
        Set<Id> accountIds = new Set<Id>();
        for(Account acc : accounts){
            accountIds.add(acc.Id);
        }
        List<Contact> contacts = getContacts(accountIds);
        
        for(Account acc : accounts){
            Integer count = 0;
            for(Contact con : contacts){
                if(con.AccountId == acc.Id){
                	count++;    
                }
            }
           	accountContactModelList.add(new AccountContactModel(acc, count));
        }
        System.debug(accountContactModelList);
        return accountContactModelList; 
    }
    //@AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
    	return [SELECT Id, Name FROM Account LIMIT 10];    
    }   
    private static List<Contact> getContacts(Set<Id> accountIds){
    	return [SELECT Id, Name, AccountId FROM Contact where AccountId IN: accountIds];    
    }
    public class AccountContactModel{
        @AuraEnabled    
        public Account acc {get;set;} 
        @AuraEnabled
        public Integer totalContacts {get;set;}
        public AccountContactModel(Account acc, Integer totalContacts){
            this.acc = acc;
            this.totalContacts = totalContacts;
        }
    }
}