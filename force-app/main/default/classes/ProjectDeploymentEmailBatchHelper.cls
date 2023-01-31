/*
    Name	 	:  ProjectBatch
    Date 		:  10 March, 2021
    Author 		:  Nezam Uddin
    Description :  This is a helper of ProjectBatch Class. In this helper i send email to the project owner and project task owner.
*/
public class ProjectDeploymentEmailBatchHelper {
    
    public static void emailTemplate(List<Project_Task__c> projectTaskList){
        List<Messaging.SingleEmailMessage> emailMessagesList = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sendEmailMessageObject = new Messaging.SingleEmailMessage();
        
        EmailTemplate emailTemplateVisualforce = [SELECT id, DeveloperName FROM EmailTemplate WHERE DeveloperName = 'Project_status_is_deployment'];
        
        for(Project_Task__c projectTaskObject : projectTaskList){ 
            sendEmailMessageObject.setTemplateId(emailTemplateVisualforce.Id);
            sendEmailMessageObject.setTargetObjectId(projectTaskObject.Project_Name__r.Project_Owner__c); 
            sendEmailMessageObject.setWhatId(projectTaskObject.Project_Name__c);
            sendEmailMessageObject.setSaveAsActivity(false);
            emailMessagesList.add(sendEmailMessageObject);                       
        }
        
        //Messaging.sendEmail(emailMessagesList);
        //emailMessagesList = new List<Messaging.SingleEmailMessage>();
       	//sendEmailMessageObject = new Messaging.SingleEmailMessage(); 
                
        EmailTemplate emailTemplateText = [SELECT id, DeveloperName FROM EmailTemplate WHERE DeveloperName = 'Project_Email_Signoff_Details'];
        
        for(Project_Task__c projectTask : projectTaskList){ 
            sendEmailMessageObject.setTargetObjectId(projectTask.Project_Name__r.Project_Owner__c);
            sendEmailMessageObject.setToAddresses( new List<String> {projectTask.Owner.Email});
            sendEmailMessageObject.setSaveAsActivity(false);  
            sendEmailMessageObject.setWhatId(projectTask.Id);
            sendEmailMessageObject.setTreatTargetObjectAsRecipient(false);
            sendEmailMessageObject.setTemplateId(emailTemplateText.Id);   
            emailMessagesList.add(sendEmailMessageObject);   
            
        }		
        Messaging.sendEmail(emailMessagesList);
    } 

}