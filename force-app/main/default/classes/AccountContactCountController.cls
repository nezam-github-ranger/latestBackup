public class AccountContactCountController {
    public List<AccountContactModel> accountContactModels {get;set;}
    public AccountContactCountController(){
        accountContactModels = new List<AccountContactModel>();
        //loadDataV1();
        
        //loadDataV2();
        
        loadDataV3();
    }
	//Version v1
    private void loadDataV1(){
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
            accountContactModels.add(new AccountContactModel(acc, count));

        }
        
    }
    
    //Version V2
    private void loadDataV2(){
        Map<Id, Account> accountMap = getAccountMap();
        Set<Id> accountIds = accountMap.keySet();
        
        List<Contact> contacts = getContacts(accountIds);
        
        for(Id accId : accountMap.keySet()){
            Account acc = accountMap.get(accId);
            Integer count = 0;
            for(Contact con : contacts){ 
                if(con.AccountId == acc.Id){
                	count++;    
                }
            }
            accountContactModels.add(new AccountContactModel(acc, count));
            
        }
        
    }
    
    //Version V3
    private void loadDataV3(){
        Map<Id, Account> accountMap = getAccountMap();
        Set<Id> accountIds = accountMap.keySet();
        
        List<Contact> contacts = getContacts(accountIds);
        Map<Id, List<Contact>> contactMap = new Map<Id, List<Contact>>();
        
        for(Contact con : contacts){
            system.debug('contact Map ==> ' + contactMap + 'contactMap.get(con.AccountId) ++> ' + contactMap.get(con.AccountId));
        	List<Contact> contactList = contactMap.get(con.AccountId);  // A/c Id(1,2)1. = 11, 2. = 22, 1. = 11, 2. = 22;
            if(contactList == null){								    //    null,   null,   value,    value;
                contactList = new List<Contact>(); 
            }	
            contactList.add(con);  //1. data1, 2. data2, 3. data3, 4. data4; 
            contactMap.put(con.AccountId, contactList);  //1.(11,data1), 2.(22,data2), 3.(11,data1&data3), 4.(22,data2&data4)
        }
        //Set<Id> ids = accountMap.keySet();
        for(Id accId : accountMap.keySet()){
            //system.debug('accId ==> ' + accId);
            //Set<Id> accIds = accountMap.keySet();
            Account acc = accountMap.get(accId);
            Integer count = 0;
            List<Contact> contactList = contactMap.get(accId);
            //system.debug('conList ==> ' + contactList);
            if(contactList != null){
                count = contactList.size();
            }
            accountContactModels.add(new AccountContactModel(acc, count));     
        }
        
    }
    
    private Map<Id, Account> getAccountMap(){
    	/*
    	Map<Id, Account> accountMap = new Map<Id, Account>();
        List<Account> accounts = [SELECT Id, Name FROM Account];
        for(Account acc : accounts){
            accountMap.put(acc.Id, acc);
        }
		*/
        
        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id,Name,Type from Account]);
        system.debug(' ## ' + accountMap);
        return accountMap;
    }
    
    private List<Account> getAccounts(){
    	return [SELECT Id, Name FROM Account];    
    }   
    
    private List<Contact> getContacts(Set<Id> accountIds){
    	return [SELECT Id, Name, AccountId FROM Contact where AccountId IN: accountIds];    
    }
    
    public class AccountContactModel{
        public Account acc {get;set;}
        public Integer totalContacts {get;set;}
        public AccountContactModel(Account acc, Integer totalContacts){
            this.acc = acc;
            this.totalContacts = totalContacts;
        }
    }
}