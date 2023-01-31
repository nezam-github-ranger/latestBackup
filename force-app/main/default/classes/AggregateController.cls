public class AggregateController {
    public AggregateController() {
        //AggregateQuery?
        //sum, count, max, min, avg
    	//getAccountContacts();
        getAccountContactsCount();
    }
    
    /*private void getAccountContacts(){
        List<AggregateResult> aggResults = [SELECT count(Id) totalContacts FROM Contact];
        System.debug('## Size: ' + aggResults.size());
        AggregateResult ar = aggResults.get(0);
        Integer count = (Integer)ar.get('totalContacts');
        System.debug('## count: ' + count);
    }*/
    
    public void getAccountContactsCount(){
        List<AggregateResult> aggResults = [SELECT count(Id) totalContacts, AccountId FROM Contact GROUP BY AccountId];
        System.debug('## Size: ' + aggResults.size());
        
        if(aggResults.size() > 0){ 
            for(AggregateResult ar : aggResults){
                Integer count = (Integer)ar.get('totalContacts'); 
                Id accountId = (Id)ar.get('AccountId'); 
                System.debug('## AccountId: ' + accountId + ', Total Contacts: ' + count);    
            }  
       }
    }
}