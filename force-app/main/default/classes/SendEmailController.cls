public class SendEmailController {
    public List<Contact> contactList {get;set;}
    public List<EmailModel> modelList {get;set;}
    public String selectedEmail {get;set;}
    public Integer serialNo;
    public List<String> senderEmailList;
    //public String[] ccEmail {get;set;}
    //public Messaging.SingleEmailMessage bccEmail {get;set;}
    //
    public String emailSubject {get;set;}
    public String emailBody {get;set;}
    
    
    public SendEmailController(){
        contactList = new List<Contact>();
        modelList = new List<EmailModel>();
        senderEmailList = new List<String>();
        serialNo = 1;
        emailBody = '';
        //ccEmail = new String[] {Lead.email};
        //bccEmail = new Messaging.SingleEmailMessage();
        
        contactList = [SELECT Id, Name, Email, Phone FROM Contact];
        
        for(Contact con : contactList){
        	modelList.add(new EmailModel(con, serialNo++));    
        }
    }
    public void checkBoxClick(){
        System.debug('selected Email ==> ' + selectedEmail);
    	senderEmailList.add(selectedEmail);   
        selectedEmail = '';   
        for(String s : senderEmailList){
        	selectedEmail = selectedEmail + s + ', ';  
        }
    }
    public PageReference send(){
        //System.debug('ccEmail ' + ccEmail);
        //System.debug('bccEmail, ' + bccEmail);
    	sendEmail(); 
        PageReference pg = new PageReference('/Apex/SendEmailPage');
        pg.setRedirect(true);
        return pg;
        
    }
    public void sendEmail(){
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sem = new Messaging.SingleEmailMessage();
        
        
        //senderEmailList.add('nezam21nex@gmail.com');
        //senderEmailList.add('nezam2125nex@gmail.com');
        //senderEmailList.add('goyalbhavya89@gmail.com');
        //senderEmailList.add('amansankhala786@gmail.com');
                            
        sem.setToAddresses(senderEmailList);
        sem.setSubject(emailSubject);
        sem.setPlainTextBody(emailBody);
        //sem.Ccaddresses(ccEmail);
        emailMessages.add(sem);
        Messaging.sendEmail(emailMessages);
    }
    
    public class EmailModel{
        public Contact conModelObject {get;set;} 
        public Boolean check {get;set;}
        public Integer serialNo {get;set;}
        
        public EmailModel(Contact conModelObject, Integer serialNo){
        	this.conModelObject = conModelObject;
            this.serialNo = serialNo;
            System.debug('check ==> '+ check);
        }
    }
}