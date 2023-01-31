@isTest
public class AggregateAssignmentTest {
    
    /*@isTest static void controllerCall(){
        Account acc = new Account(Name = 'Demo Account Name');
        Insert acc;
        AggregateAssignmentController aac = new AggregateAssignmentController();
        
        
    }*/
    testMethod static void loadMethodCall(){
        Account acc = new Account(Name = 'Test Demo Account');
        Insert acc;
        AggregateAssignmentController aac = new AggregateAssignmentController();
   	    Contact con = new Contact(LastName = 'Test Demo Contact', AccountId = acc.Id);
        Insert con;
    	aac.loadContactCount();    
    }
}