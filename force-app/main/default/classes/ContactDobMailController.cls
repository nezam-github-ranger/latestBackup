public class ContactDobMailController {
    
    public List<Contact> allContacts(){
        return [SELECT Email, Birthdate FROM Contact];
    }
    
}