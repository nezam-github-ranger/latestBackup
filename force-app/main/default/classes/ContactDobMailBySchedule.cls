global class ContactDobMailBySchedule implements Schedulable {
    ContactDobMailController conController;
    List<Contact> contactList = conController.allContacts();
    
    global void execute(SchedulableContext SC){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setToAddresses(new List<String>{'pankaj.g@ibirdsservices.com'});
        message.setSubject('Daily Information');
        message.setHtmlBody('Hi Pankaj <br/> Please find org wise daily updation <br/> Total Account : <br/> Total Contact : <br/> Thanks');
		
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] result = Messaging.sendEmail(messages);
        if(result[0].success){
            System.debug('@@ email send successfully');
        } else {
            System.debug('Error : '+ result[0].errors[0].message);
        }
    }
}