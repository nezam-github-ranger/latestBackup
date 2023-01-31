trigger AccountTrigger on Account (before insert, after insert, before update, after update, before delete, after undelete) {
    
    if(Trigger.isInsert && Trigger.isAfter){
        AccountHierarchy.createContact(Trigger.new);    
        //AccountHierarchy.fetchLevelOfHierarchy(trigger.new);
        //AccountHelperOnInsert.insertHandle(Trigger.newMap);
    }
    
    if(Trigger.isUpdate && Trigger.isBefore){
        //AccountHelperOnUpdate.updateOpportunityHandle(Trigger.newMap);
        AccountHelperOnUpdate.calculateAssignHours(Trigger.newMap, Trigger.oldMap);
    }
    
    
    if(Trigger.isUpdate && Trigger.isAfter){
        //AccountHelperOnUpdate.afterTriggerExample(Trigger.oldMap, Trigger.newMap);
        //AccountHelperOnUpdate.changeStageHandle(Trigger.newMap);
        //AccountHelperOnUpdate.manuallyTypeChangePrevent(Trigger.oldMap, Trigger.newMap);
    }
    /*
    //when any record is deleted then this method is call
    if(Trigger.isDelete){
        System.debug('Delete Method ==> ' + Trigger.old);
        AccountHelperOnDelete.deleteHandle(Trigger.old);
        AccountHelperOnDelete.AnnualRevenueHandle(Trigger.old);
    }
    
    //when any record is undelete then this method is call
    if(Trigger.isUndelete){
        System.debug('Undelete Method ==> ' + trigger.newMap);
        AccountHeleperOnUndelete.undeleteHandle(Trigger.newMap);
    }*/
    
}