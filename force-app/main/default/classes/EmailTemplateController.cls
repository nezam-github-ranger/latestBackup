public class EmailTemplateController {

    public Id projectId {get;set;}
    public List<Project_Task__c> getProjectTaskList(){
    	return [SELECT Type__c, Completion_Date__c, CreatedDate, CreatedBy.Name FROM Project_Task__c WHERE Project_Name__c =: projectId];  
    }
}