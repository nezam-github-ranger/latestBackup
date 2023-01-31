trigger TaskTrigger on Task (before delete) {

    if(Trigger.isDelete && Trigger.isBefore){
    	TaskDeleteHandler.validateDeletedRecord(Trigger.old);	    
    }
	    
    
}