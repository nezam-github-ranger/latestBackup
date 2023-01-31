trigger CollaborationGroupTrigger on CollaborationGroup (before insert) {
    
    if(Trigger.isInsert && Trigger.isBefore){
        //CollaborationGroupTriggerHandler.handleBeforeInsert(Trigger.new);
    }

}