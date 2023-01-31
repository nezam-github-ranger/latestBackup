trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert, before update, before delete) {
		
    if(Trigger.isInsert && Trigger.isBefore){
    	OpportunityLineItemTriggerHandler.handleOnInsert(Trigger.new);    
    }
    if(Trigger.isUpdate && Trigger.isBefore){
    	OpportunityLineItemTriggerHandler.handleOnUpdate(Trigger.newMap, Trigger.oldMap);    
    }
    if(Trigger.isDelete && Trigger.isBefore){
    	OpportunityLineItemTriggerHandler.handleOnDelete(Trigger.old);	
    }
    
}