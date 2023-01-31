public class BulkUpsertContactController {
    public List<Contact> contacts {get;set;}
    public String firstName {get;set;}
    public Contact con {get;set;}
    public BulkUpsertContactController(){
        contacts = [SELECT Id, FirstName, LastName, Email, BirthDate FROM Contact];
    	con = new Contact();
    }
    
    public PageReference save(){
        upsert contacts;
        return null;
    }
    
    public void search(){
        String fName = '%' + firstName + '%';
        contacts = [SELECT Id, FirstName, LastName, Email, Birthdate
                    FROM Contact
                   	WHERE FirstName like : fName
                   	AND Birthdate >=: con.Birthdate];
    }
}