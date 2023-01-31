public class CheckAllBookingAsCompletedBatch implements Database.Batchable<sObject>, Database.Stateful {
	
    public Database.QueryLocator start(Database.BatchableContext bc){
    	return Null;    
    }
    public void execute(Database.BatchableContext bc, List<sObject> sObjectList){
        
    }
    public void finish(Database.BatchableContext bc){
        
    }
    
}