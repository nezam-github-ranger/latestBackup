/*
	Name : AccountContactCount
	Date : 25/3/2021
	Subject : This AccountContactCount controller is used to count of all the contact of accounts.

*/
public class AccountContactCount {
	public List<AccountContactModel> accountContactModelList {get;set;}
    public Boolean checkbox {get;set;} 
    
    public AccountContactCount(){
        /*
        List<AggregateResult> contactList = [Select Count(Id) contactCount, Account.Name from Contact GROUP BY Account.Name];
        System.debug('contact lsit ==> ' + contactList);
        
        for(AggregateResult aggregateResultObject : contactList){
        	accountContactModelList.add(new AccountContactModel(aggregateResultObject.Name));    
        }
		*/       
			        
        checkbox = false;
        accountContactModelList = new List<AccountContactModel>();
    	Map<Id, Account> accountMap = getAccountMap();
        Set<Id> accountIds = accountMap.keySet();
        
        List<Contact> contacts = getContacts(accountIds);
        Map<Id, List<Contact>> contactMap = new Map<Id, List<Contact>>();
        
        for(Contact con : contacts){
            system.debug('contact Map ==> ' + contactMap + 'contactMap.get(con.AccountId) ++> ' + contactMap.get(con.AccountId));
        	List<Contact> contactList = contactMap.get(con.AccountId);  
            if(contactList == null){								   
                contactList = new List<Contact>(); 
            }	
            contactList.add(con);  
            contactMap.put(con.AccountId, contactList);
        }
        for(Id accId : accountMap.keySet()){
           Account acc = accountMap.get(accId);
            Integer count = 0;
            List<Contact> contactList = contactMap.get(accId);
            if(contactList != null){
                count = contactList.size();
            }
            accountContactModelList.add(new AccountContactModel(acc, count));   
            
            System.debug('acc ==> ' + accountContactModelList);
        }	    
    }
    private Map<Id, Account> getAccountMap(){
    	Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Name from Account]);
        system.debug(' ## ' + accountMap);
        return accountMap;		    
    }
    
    private List<Contact> getContacts(Set<Id> accountIds){
    	return [SELECT Id, Name, AccountId FROM Contact where AccountId IN: accountIds];    
    }
    public void changeMethod(){
        checkbox = !checkbox;
    }
    public class AccountContactModel{
        public Account accountObject {get;set;}
        public Integer totalContacts {get;set;}
        public AccountContactModel(Account accountObject, Integer totalContacts){
            this.accountObject = accountObject;
            this.totalContacts = totalContacts;
        }
    }
}