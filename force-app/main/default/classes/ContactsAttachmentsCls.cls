public class ContactsAttachmentsCls {
	
    public List<Contact> contactList;
    public ContactsAttachmentsCls(){
        
        SObject[] queryParentObject = Database.query('SELECT Id, CaseNumber,Status, (SELECT Id, Name FROM Attachments) FROM Case');
        
        System.debug('queryParentObject ==> ' + queryParentObject);
        
    }
    
    
}