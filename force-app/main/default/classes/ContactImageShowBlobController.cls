public class ContactImageShowBlobController {
    public List<AttachmentWrapperClass> showList {get;set;} 
    public List<Attachment> attachmentList {get;set;}
    public List<Contact> contactList {get;set;}
    
    public ContactImageShowBlobController(){
        showList = new List<AttachmentWrapperClass>();
        attachmentList = new List<Attachment>();
        contactList = new List<Contact>();
        
        contactList = [SELECT Id, Name FROM Contact];
        attachmentList = [Select Id, parentId From Attachment Where parentId =: contactList];
        //System.debug('att List => '+ attachmentList);
        for(Contact c : contactList){
            Boolean check = true;
            for(Attachment a : attachmentList){
                if(a.ParentId == c.Id){
                	showList.add(new AttachmentWrapperClass(c,a));
                    //System.debug('att1 => ' + showList);
                    check = false;
                    break;
                }
            }   
            if(check){
                Attachment attach = new Attachment();
                attach.Id = Null ;
                showList.add(new AttachmentWrapperClass(c,attach));
                System.debug('id ==> ' + attach.Id);
            }        
        }
    }
    public PageReference upload() {
        List<Attachment> attUploadList = new List<Attachment>();
  		Attachment attachment = new Attachment();
        for(AttachmentWrapperClass aWrapper : showList){
            if(aWrapper.attachment.body != Null){
                aWrapper.attachment.ContentType = 'image/jpeg';
                aWrapper.attachment.parentId = aWrapper.conList.Id;
                //attachment.Body = blob.toPdf(attachment.body);
               // attUploadList.add(aWrapper.attachment);
            }
            insert attachment;
        }
        //upsert attUploadList;
        PageReference pg = new PageReference('/apex/ContactImageShow');
        pg.setRedirect(true);
        
        return pg;
    }
    public class AttachmentWrapperClass{
        public Contact conList {get;set;}
        public Attachment attList {get;set;}
        public Attachment attachment {get;set;}
       	Blob myBlob;
        
        public AttachmentWrapperClass(Contact c, Attachment a){
            attachment = new Attachment();
            //myBlob = new Blob();
            conList = c;
            attList = a;
            //System.debug('att => ' + attList);
        } 
    }
}