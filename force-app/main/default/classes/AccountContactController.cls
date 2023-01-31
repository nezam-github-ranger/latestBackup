public class AccountContactController {
    public List<Contact> contactList {get;set;}
    
    public AccountContactController(){
    	contactList = new List<Contact>();
        Id contactId = ApexPages.currentPage().getParameters().get('Id');
        if(contactId != Null){
        	contactList = [SELECT AccountId, Name, Phone, Fax, Email FROM Contact WHERE Id =: contactId];
        }
    }
}