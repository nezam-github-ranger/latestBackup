public class BulkDataHandleBatch implements Database.Batchable<sObject>, Database.Stateful  {
    
    String data;
    Integer counter;
    Integer endWith;
    List<Contact> contactList = new List<Contact>();
    
    public BulkDataHandleBatch(String data, Integer counter, Integer endWith){
        this.data = data;
        this.counter = counter;
        this.endWith = endWith;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT FirstName, LastName, Email FROM Contact WHERE Email = 'nezam21nex@gmail.com' LIMIT 1]);
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> contact){
        System.debug('contact => ' + contact);
        //String header = 'FirstName,LastName,Email\n';
        while(counter<endWith){
            data = data +'Test' + counter +',LastNameTest' + counter + ',test' + counter + '@prk.com\n'; 
            counter++;
        }
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug('finish method call : \n' +data);	
        if(counter < 100000){
            BulkDataHandleBatch batchObj = new BulkDataHandleBatch(data, counter,counter + 10000);
            Database.executeBatch(batchObj, 1);    
        }
        else{
            Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
            csvAttc.setFileName('DemoData.csv');
            csvAttc.setBody(Blob.valueOf(data));
            System.debug('csv data in blob format ==> ' + Blob.valueOf(data));
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject('100000 Record CSV');
            email.setToAddresses( new List<String> {'nezam21nex@gmail.com'} );
            email.setPlainTextBody('CSV data generated by batch class!!');
            email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            System.debug('result ==> ' + r ); 
        }
    }
    
}