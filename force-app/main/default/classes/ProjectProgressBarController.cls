public with sharing class ProjectProgressBarController {
    
    @AuraEnabled(cacheable = true)
    public static List<Project__c> getProjects(Id recordId){
        return [SELECT Id, Status__c FROM Project__c WHERE Id =: recordId];
    }

}