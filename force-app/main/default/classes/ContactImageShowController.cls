public class ContactImageShowController {
    public List<AttachmentWrapperClass> showList {get;set;} 
    public List<Attachment> attachmentList {get;set;}
    public List<Contact> contactList {get;set;}
    public Set<Id> contactIds;
   
    public ContactImageShowController(){
        showList = new List<AttachmentWrapperClass>();
        attachmentList = new List<Attachment>();
        contactList = new List<Contact>();
        contactIds = new Set<Id>();
        
        contactList = [SELECT Id, Name FROM Contact];
        for(Contact con : contactList){
           contactIds.add(con.Id);
        }
        
        attachmentList = [Select Id, parentId From Attachment Where parentId In: contactIds];
     
        for(Contact con : contactList){
            System.debug('con ==> '+ con);
            Boolean check = true;
            for(Attachment att : attachmentList){
                if(att.ParentId == con.Id){
                	showList.add(new AttachmentWrapperClass(con,att));
                    check = false;
                }
            }   
            if(check){
                Attachment attach = new Attachment();
                attach.Id = Null ;
                showList.add(new AttachmentWrapperClass(con,attach));
            }        
        }
    }
    public PageReference upload() {
        List<Attachment> attUploadList = new List<Attachment>();
  		//Attachment attachment = new Attachment();
        for(AttachmentWrapperClass aWrapper : showList){
            if(aWrapper.attachment.body != Null){
                //aWrapper.attachment.ContentType = 'image/jpeg';
                aWrapper.attachment.parentId = aWrapper.conList.Id;
                attUploadList.add(aWrapper.attachment);
            }
        }
        upsert attUploadList;
        PageReference pg = new PageReference('/apex/ContactImageShow');
        pg.setRedirect(true);
        return pg;
    }
    public class AttachmentWrapperClass{
        public Contact conList {get;set;}
        public Attachment attList {get;set;}
        public Attachment attachment {get;set;}
        
        public AttachmentWrapperClass(Contact c, Attachment a){
            attachment = new Attachment();
            conList = c;
            attList = a;
        } 
    }
}