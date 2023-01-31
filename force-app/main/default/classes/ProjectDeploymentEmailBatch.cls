/*
    Name	 	:  ProjectBatch 
    Date 		:  10 March, 2021
    Author 		:  Nezam Uddin
    Description :  This is a ProjectDeploymentEmailBatch of project task. In this batch automatically email send to the deployment status project task.
*/
global class ProjectDeploymentEmailBatch implements Database.Batchable<sObject>, Database.Stateful{ 
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, Project_Name__r.Project_Owner__c, Owner.Email, Project_Name__c FROM Project_Task__c WHERE Type__c = 'Completion Step' AND Project_Name__r.Status__c = 'Deployment']);
    }
    global void execute(Database.BatchableContext bc, List<Project_Task__c> projectList){
        ProjectDeploymentEmailBatchHelper.emailTemplate(projectList);
    }
    global void finish(Database.BatchableContext bc){
        System.debug('finish method ==> '); 
    }

}