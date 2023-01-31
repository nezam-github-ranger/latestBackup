public class SavePointDemo {
	Public Static Boolean stopTheExecution=true;
    public void demoMethod(){
        Try{   
            System.debug('Save Point Demo Method');
            Savepoint sp = Database.setSavepoint();         
            Account acc = new Account(Name='Test', Email__c ='test@savepoint.com');
            insert acc;	
            System.debug('acc ==> ' + acc);
            System.debug('stop ex ==> ' + stopTheExecution);
            if(stopTheExecution == false){
            	Database.rollback(sp);
          	}
            Savepoint sp2 = Database.setSavepoint();  
            System.debug('--account created ?-- '+acc.Id);
            Contact con = new Contact(LastName='TestCon');
            insert con;
            System.debug('--Contact created '+con.Id+ ' ====Static variable== '+stopTheExecution);
            if(stopTheExecution==false){
            	Database.rollback(sp2);  
            }
        }
        catch(Exception exe){
            System.debug('Handle Exception or create error log');
        }
    }
}