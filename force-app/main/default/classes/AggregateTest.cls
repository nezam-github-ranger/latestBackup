@isTest
public class AggregateTest {
	
    @isTest static void getAccountContact(){
        Account acc = new Account(Name = 'Test Demo Account');
        Insert acc;
        Contact con = new Contact(LastName = 'Test Demo Contact', AccountId = acc.Id);
        Insert con;
    	AggregateController ag = new AggregateController();		
    }
}