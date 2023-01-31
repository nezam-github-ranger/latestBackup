@isTest
public class ContactDetailsTest {
    @isTest static void contactDetailControllerCall(){
        Account acc = new Account(Name = 'Test Demo Account');
        Insert acc;
   	    Contact con = new Contact(LastName='Test Demo Contact', Email='contact@demo.com', AccountId = acc.Id, Phone='9983437743');
        Insert con;
        ContactDetailsController cdc = new ContactDetailsController();
        cdc.inputText = 'test';
 		cdc.searchMethod();
    }	
}