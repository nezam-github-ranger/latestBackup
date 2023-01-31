public class ContactController {

    @AuraEnabled(cacheable=true)
    public static List<Contact>  getContacts(){
        return [SELECT Id, FirstName, LastName, Email FROM Contact];
    }
	
    @AuraEnabled(cacheable=true)
    public static List<Contact>  getContactRecords(){
        
        return [SELECT Id, Name, Email, Phone, Account.Name FROM Contact LIMIT 1];
    	
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact>  getContactRecordsAccordingAcccountName(String accountName){
        Account acc = new Account(Name=accountName);
        INSERT acc;
        System.debug('acc ==> ' + acc);
        return [SELECT Id, Name, Email, Phone, Account.Name FROM Contact WHERE Account.Name =: accountName LIMIT 5];
    	
    }

}