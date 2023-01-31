public class SendEmailClassController {
    
    public SendEmailClassController(){
        
    }
    
    public static void sendEmail(){
       	List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sem = new Messaging.SingleEmailMessage();
        List<String> emailAddresses = new List<String>{'nezam21nex@gmail.com'};
        sem.setToAddresses(emailAddresses);
        sem.setSubject('Email Message using Apex');
        String body = 'Hi,<br/>';
        body += 'This is just an example of Email Message!' 
            	+ '<br/><br/>Thanks<br/><br/>' + UserInfo.getUserName();
        		
        sem.setHtmlBody(body);
        emailMessages.add(sem);
        Messaging.sendEmail(emailMessages);
    }
    
    public static void sendEmailTemplate(){
       	List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sem = new Messaging.SingleEmailMessage();
        //List<String> emailAddresses = new List<String>{'ab.vahid@gmail.com', 'abdul.vahid@ibirdsservices.com'};
        //sem.setToAddresses(emailAddresses);
        
        //Query Email Template
        
        List<EmailTemplate> emailTemplates =  getEmailTemplates('Registration_Email_Template');
        Id contactId = getTargetObjectId('0035g000001nmQbAAI');
        if(!emailTemplates.isEmpty() && contactId != null){
            sem.setTemplateId(emailTemplates.get(0).Id);
            sem.setTargetObjectId(contactId); //ContactId, Or LeadId or UserId
            emailMessages.add(sem);
            Messaging.sendEmail(emailMessages);
        }
    }
    
    public static void sendEmailTemplate2(){
       	List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sem = new Messaging.SingleEmailMessage();
        //List<String> emailAddresses = new List<String>{'ab.vahid@gmail.com', 'abdul.vahid@ibirdsservices.com'};
        //sem.setToAddresses(emailAddresses);
        
        //Query Email Template
        
        List<EmailTemplate> emailTemplates =  getEmailTemplates('Opportunity_is_Closed');
        Id objectId = getOpportunityObjectId('0065g000002MG78AAG');
        
        if(!emailTemplates.isEmpty() && objectId != null){
            sem.setTemplateId(emailTemplates.get(0).Id);
            sem.setTargetObjectId('0035g000001nmQbAAI'); //ContactId, Or LeadId or UserId or Person
            //if Template Id is used then targetObjectId will be required. 
            sem.setWhatId(objectId);
            emailMessages.add(sem);
            Messaging.sendEmail(emailMessages);
        }
    }
    
    //Opportunity_is_Closed
    private static Id getTargetObjectId(String id){
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Id =: id];
        return contacts.isEmpty() ? null : contacts.get(0).Id;
    }
    
    //Opportunity_is_Closed
    private static Id getOpportunityObjectId(String id){
        List<Opportunity> opps = [SELECT Id FROM Opportunity WHERE Id =: id];
        return opps.isEmpty() ? null : opps.get(0).Id;
    }
    
    private static List<EmailTemplate> getEmailTemplates(String emailTemplateName){
        return [SELECT id FROM emailtemplate WHERE DeveloperName =: emailTemplateName];
    }
}