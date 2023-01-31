public class AggregateAssignmentController {
    public List<ContactModel> modelList {get;set;} 
    public Map<String, Integer> contactCountMap;
    public List<Account> accountObj;
    public List<AggregateResult> aggResults;
    
    public AggregateAssignmentController(){
    	modelList = new List<ContactModel>();
        contactCountMap = new Map<String, Integer>();
        accountObj = [SELECT Id, Name FROM Account];
        loadContactCount();
    }
    public void loadContactCount(){
        aggResults = [SELECT count(Id) totalContacts, AccountId FROM Contact GROUP BY AccountId];
        System.debug('## Size: ' + aggResults.size());
        
        for(AggregateResult ar : aggResults){
        	Integer count = (Integer)ar.get('totalContacts');
            String accountId = (Id)ar.get('AccountId'); 
        	System.debug('## AccountId: ' + accountId + ', Total Contacts: ' + count);    
            contactCountMap.put(accountId, count);
        } 
        for(Account ac : accountObj){
            if(contactCountMap.containsKey(ac.Id)){
                modelList.add(new ContactModel(ac.Name, contactCountMap.get(ac.Id)));
            }else{
            	modelList.add(new ContactModel(ac.Name, 0));  
            }
        }
    }
    public class ContactModel{
        public String accountName {get;set;}
        public Integer contactCount {get;set;}
        
        public ContactModel(String accountName, Integer contactCount){
            this.accountName = accountName;
            this.contactCount = contactCount;
        }
        
    }
}