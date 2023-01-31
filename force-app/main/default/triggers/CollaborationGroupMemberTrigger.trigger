trigger CollaborationGroupMemberTrigger on CollaborationGroupMember (after insert, after delete) {
    
    if(Trigger.isInsert && Trigger.isAfter){
    	CollaborationGroupMemberHelper.handleAfterInsert(Trigger.newMap.keySet());
    }
    
    if(Trigger.isDelete && Trigger.isAfter){ 
    	CollaborationGroupMemberHelper.handleAfterDelete(Trigger.old);
    }
}