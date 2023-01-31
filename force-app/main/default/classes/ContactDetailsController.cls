public class ContactDetailsController {   
    public List<Contact> contactList{get;set;}
    public String inputText {get;set;} 
    
    public ContactDetailsController(){            
        contactList = [SELECT Name, Email, AccountId, Phone FROM Contact LIMIT 100];
    }
     
    public void searchMethod(){                         
    	String searchVal = '%' + inputText + '%'; 
        String query = 'SELECT Name, Email, AccountId, Phone FROM Contact WHERE ';
        if(inputText != Null){
        	contactList = Database.query(query + 'Name Like : searchVal OR Email Like : searchVal LIMIT 100');
        }
    }
}