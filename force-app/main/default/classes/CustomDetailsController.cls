public class CustomDetailsController {
     
    //create contact mehtod
    @AuraEnabled
    public static void saveContact(Contact contactObj){
        System.debug('contact ==> ' + contactObj);
        
        if(String.isNotBlank(contactObj.Id)){
        	System.debug('contact id ==> ' + contactObj.Id);
            System.debug('in update');
        	UPDATE contactObj;
        } 
        else {
            System.debug('In insert');
            contactObj.Id = Null;
        	INSERT contactObj;
        }
        
        
    }
    
    //edit contact method
    @AuraEnabled
    public static List<Contact> getContact(){
        List<Contact> lstContact = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact ORDER BY CreatedDate DESC LIMIT 5];
        System.debug('lstContact ==> ' + lstContact);
        return lstContact;
    }
    
    //delete contact method
    @AuraEnabled
    public static void deleteContact(String deletedId){
        Contact contactObj = [SELECT Id FROM Contact WHERE Id =: deletedId];
        System.debug('delte call');
        if(contactObj != Null){
            System.debug('contact delete ==> ' + contactObj);
            delete contactObj;
        }
    }
    
    //edit contact method
    @AuraEnabled
    public static Contact editContact(String editedId){
    	Contact contactObj = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE Id =: editedId];
        System.debug('contact obj ==> ' + contactObj);
        return contactObj;
    }
    
}