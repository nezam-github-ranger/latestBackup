@isTest
public class AttachmentCopyTest {
	
    testMethod static void attachmentControllerCall(){
        AttachmentCopyController attCopyObject = new AttachmentCopyController();
        
        //String selectedObject = 'Account';
        //acc.selectedObject = 'Account';
        //acc.loadNewList();
        
        /*acc.attachmentCheck();
        acc.attachmentCheckAll();
        acc.assignToCheckAll();  
        acc.assignObjectDetails();
        acc.copyTo();
        acc.closePopup();
        acc.search();
        acc.submit();*/
    }
    testMethod static void attachmentCopyModel(){
    	AttachmentCopyController attCopyObject = new AttachmentCopyController();
        attCopyObject.selectedObject = 'Account';
        Account accountObject = new Account(Name = 'Account 1');
        Insert accountObject;
        attCopyObject.loadNewList();
        
        Attachment attach = new Attachment();   	
    	attach.Name='Attachment 1';
    	Blob bodyBlob = Blob.valueOf('Attachment Body 1');
    	attach.body = bodyBlob;
        attach.parentId = accountObject.id;
        insert attach;
        attCopyObject.attachmentCheck();
        
        AttachmentCopyController.AttachmentCopyModel attCopyModelObj;
        //attCopyModelObj.check = true;
        //List<AttachmentCopyController.AttachmentCopyModel> attachList = new List<AttachmentCopyController.AttachmentCopyModel>();
        attCopyObject.attachModel.add(new AttachmentCopyController.AttachmentCopyModel(attach, attach.Name.substringAfter('.').toUpperCase()));
        
        
        attCopyObject.selectedObject = 'Contact';
        Contact contactObject = new Contact(LastName = 'Contact 1');
        Insert contactObject;
        attCopyObject.loadNewList();
        
        attCopyObject.selectedObject = 'Campaign';
        Campaign campaignObject = new Campaign(Name = 'Campaign 1');
        Insert campaignObject;
        attCopyObject.loadNewList();
    }
    testMethod static void checkAttachementCall(){
        AttachmentCopyController attCopyObject = new AttachmentCopyController();
        attCopyObject.checkAllAttachment = true;
        attCopyObject.attachmentCheckAll();
        
        attCopyObject.checkAllAttachment = false;
        attCopyObject.attachmentCheckAll();
        
        //List<AttachmentCopyController.attachModel> attachmentList = new List<AttachmentCopyController.attachModel>()
   
          
    } 
    @isTest static void checkCall(){
        AttachmentCopyController attCopyObject = new AttachmentCopyController();
        attCopyObject.assignToCheckAll = true;
        attCopyObject.assignToCheckAll();
        
        
        //attCopyObject.assignToCheck();
        
        List<Account> accountList = new List<Account>();
        List<Contact> contactList = new List<Contact>();
        List<Campaign> campaignList = new List<Campaign>();
        
        attCopyObject.accountList = accountList;
        attCopyObject.assignObjectDetails();
        
        attCopyObject.copyTo();
        
        attCopyObject.displayPopUp = false;
        attCopyObject.closePopup();
    }
    testMethod static void submitMethodCall(){
    	AttachmentCopyController attCopyObject = new AttachmentCopyController();
        //List<attCopyObject.ObjectDetailsModel> 
        attCopyObject.submit();
    }
}