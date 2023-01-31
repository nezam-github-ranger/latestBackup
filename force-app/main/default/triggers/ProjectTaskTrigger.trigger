/*
    Name	 	:  ProjectTriggerHelper
    Date 		:  06 March, 2021
    Author 		:  Nezam Uddin
    Description :  This is a project task trigger. In this trigger check update value have any attachment or not and also update the correct values.
*/
trigger ProjectTaskTrigger on Project_Task__c (after update){
    Map<Id,Project_Task__c> projectTaskNewMap = trigger.newMap;
    List<Project_Task__c> projectTaskUpdateList = new List<Project_Task__c>();
    Set<Id> projectTaskId = new Set<Id>();
    
    for(Project_Task__c projectTaskObject : projectTaskNewMap.values()){
        if(projectTaskObject.Completed__c && !(Trigger.oldMap.get(projectTaskObject.Id).Completed__c)){
            projectTaskId.add(projectTaskObject.Id);
            projectTaskUpdateList.add(projectTaskObject);
        }  
    }
    
    ProjectTaskTriggerHelper.projectTaskUpdate(projectTaskUpdateList);   
    ProjectTaskTriggerHelper.projectAttachmentError(projectTaskId, projectTaskNewMap);
}