/*
    Name	 	:  ProjectTrigger
    Date 		:  06 March, 2021
    Author 		:  Nezam Uddin
    Description :  This is a trigger of project trigger. In this trigger i only call the helper class of the ProjectTrigger. This trigger is call when any record is inserted.
*/
trigger ProjectTrigger on Project__c (after insert){ 
    
    if(trigger.isInsert){
    	ProjectTriggerHelper.projectTaskInsert(trigger.new);    
    }
}