public class AccountHierarchy {
    
    public static void createContact(List<Account> accountList){
        System.debug('accountList ==> ' + accountList);
		List<Contact> contactList = new List<Contact>();
        for(Account acc : accountList){
        	contactList.add(new Contact(LastName=acc.Name + 'Created By Trigger', Email=acc.Email__c));
        }
        System.debug('contactList ==> ' + contactList);
        INSERT contactList;
    }
    
    public static void fetchLevelOfHierarchy(List<Account> accountList){
        system.debug('accountList ==> ' + accountList);
        Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Name, ParentId FROM Account]);
        System.debug('accountMap ==> ' + accountMap);    
        String accountSerial;
        Map<String, List<Account>> firstChild = new Map<String, List<Account>>();
        Integer temp=0;
        for(Integer i=0; i<= accountList.size(); i++){
            Account acc = accountList[temp];
            accountSerial = acc.Name + ' ==> ';
            for(Account accObj: accountMap.values()){
                
                if(acc.ParentId != Null && acc.ParentId == accObj.Id){
                    System.debug('step1');
                    accountSerial += accObj.Name + ' -> '; 
                    if(accObj.ParentId != Null){
                        fetchParentAccount();
                    }
                    /*if(firstChild.containsKey(acc.Name)){
                        System.debug('step2');
                        firstChild.get(acc.Name).add(accObj); 
                        if(firstChild.size() > temp){
                            //temp++;
                        }
                    }else{
                        System.debug('step3');
                        firstChild.put(acc.Name, new List<Account>());
                        if(firstChild.size() > temp){
                            //temp++;
                        }
                    }*/
                }	    
            }
        }
        System.debug('firstChild ==> ' + firstChild);
    }
    public static void fetchParentAccount(){
        
    }
}