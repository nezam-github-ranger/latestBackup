/*
    Name	 	:  ProjectTaskTriggerHelper
    Date 		:  06 March, 2021
    Author 		:  Nezam Uddin
    Description :  This is a helper of project task trigger. When any record is update in project task then project status automatically changed.
*/
public class ProjectTaskTriggerHelper {
    
    public static void projectTaskUpdate(List<Project_Task__c> projectTaskList){
        Set<Id> projectsId = new Set<Id>();
       
        for(Project_Task__c projectTaskObject : projectTaskList){
            projectsId.add(projectTaskObject.Project_Name__c); 
        }
        
        Map<Id,Project__c> projectMap = new Map<Id,Project__c>([SELECT Id, Status__c FROM Project__c WHERE Id IN: projectsId]);
        
        for(Project_Task__c projectTaskObject : projectTaskList){
            Project__c projectObject = projectMap.get(projectTaskObject.Project_Name__c);
            
            if(projectTaskObject.Completed__c){
                if(projectTaskObject.Type__c.equals('New Task')){
                    projectObject.Status__c = 'New';
                }
                else if(projectTaskObject.Type__c.equals('Planning Phase')){
                    projectObject.Status__c = 'Planning';
                }
                else if(projectTaskObject.Type__c.equals('Construction Work')){
                    projectObject.Status__c = 'Construction';
                }
                else if(projectTaskObject.Type__c.equals('Completion Step')){
                    projectObject.Status__c = 'Deployment';
                }
                else if(projectTaskObject.Type__c.equals('Contract End')){
                    projectObject.Status__c = 'Signoff';
                }
                projectMap.put(projectObject.Id, projectObject);
                 
            } 
        }
        if(projectMap.size() > 0){
			Update projectMap.values();
        }
    }
    public static void projectAttachmentError(Set<Id>projectTaskIds, Map<Id, Project_Task__c> projectTaskMap){
        Map<Id,List<Attachment>> attachmentMap = new Map<Id,List<Attachment>>(); 
        for(Attachment attachmentObject : [SELECT ParentId, Name, Description 
                                           FROM Attachment 
                                           WHERE ParentId IN: projectTaskIds  
                                           AND Description =: 'Terms & Conditions']){
           List<Attachment> attachmentList = attachmentMap.get(attachmentObject.ParentId);
           if(attachmentList == Null){
               attachmentList = new List<Attachment>();
           }
           attachmentList.add(attachmentObject);                                  
           attachmentMap.put(attachmentObject.ParentId, attachmentList);	                                       
       }
        
        for(Id projectTaskId : projectTaskIds){
            if(attachmentMap.get(projectTaskId) == Null || attachmentMap.get(projectTaskId).size() == 0){
                projectTaskMap.get(projectTaskId).addError('Please put a attachment of this record and its descripton value is "Terms & Conditions".');       
            }
        }
    }
}