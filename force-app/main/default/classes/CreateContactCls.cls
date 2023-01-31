public class CreateContactCls {

    @AuraEnabled
    public static String createContactDemo(Contact conObj){
        System.debug('conObj  ==> ' + conObj);
        insert conObj;
        return conObj.Id;
    }
    
    @AuraEnabled
    public static List<Contact> retrieveContacts(){
        return [SELECT Id, FirstName, LastName, Email FROM Contact LIMIT 10];
    }
    
}