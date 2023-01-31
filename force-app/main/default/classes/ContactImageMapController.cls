public class ContactImageMapController {
    public List<ContactModel> conModel {get;set;}
    
    public ContactImageMapController(){
        conModel = new List<ContactModel>();
        Set<Id> conIdSet = new Set<Id>();
        for(Contact con : [SELECT Id, Name FROM Contact]){
            conIdSet.add(con.id);
        }
        Integer i = 0;
        for(Attachment attach : [SELECT id, Name, Body, ParentId, Parent.Name FROM Attachment WHERE ParentId IN : conIdSet]){
            i++;
            ContactModel cm = new ContactModel(attach.Parent.Name, attach, i);
            conModel.add(cm); 
        }
    }
    public class ContactModel{
        public String contactName{get; set;}
        public List<Attachment> attachmentsList {get; set;}
        public Integer serialNo {get;set;}
        
        public ContactModel(String contactName, Attachment attachments, Integer serialNo){
            attachmentsList = new List<Attachment>();
            this.contactName = contactName;
            attachmentsList.add(attachments);
            this.serialNo = serialNo; 
        }
    }
}