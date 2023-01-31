public class AttachmentCopyController {
    public List<SelectOption> objectOptions {get;set;}
    public String selectedObject {get;set;}
    public String assignObject {get;set;}
    public List<Attachment> attachList {get;set;}
    public Boolean hidePopup {get;set;}
    public List<AttachmentCopyModel> attachModel {get;set;}
    public List<ObjectDetailsModel> objDetails {get;set;}
    public Boolean displayPopUp{get;set;}
    public Boolean hideDetails{get;set;}
    public String searchName {get;set;}
    public List<Account> accountList;
    public List<Contact> contactList;
    public List<Campaign> campaignList;
    public Boolean copyToButtonHide {get;set;}
    public Boolean checkAllAttachment {get;set;}
    public Boolean assignToCheckAll {get;set;}
    public List<Attachment> attachmentCheckList;
    
    
    public AttachmentCopyController(){
        hidePopup = false;
        hideDetails = false;
        copyToButtonHide = true;
        attachmentCheckList = new List<Attachment>();
        attachModel = new List<AttachmentCopyModel>();
        objectOptions = new List<SelectOption>();
        objectOptions.add(new SelectOption('', '--None--'));
        objectOptions.add(new SelectOption('Account', 'Account'));
        objectOptions.add(new SelectOption('Contact', 'Contact')); 
        objectOptions.add(new SelectOption('Campaign', 'Campaign'));
    }
    public void loadNewList(){
        hidePopup = true;
        List<Account> accountsId = new List<Account>();
        List<Contact> contactsId = new List<Contact>();
        List<Campaign> campaignId = new List<Campaign>();
        attachModel = new List<AttachmentCopyModel>();
        Switch on selectedObject{
            When 'Account'{
                accountsId = Database.query('SELECT Id FROM Account');
            }
            When 'Contact'{ 
                contactsId = Database.query('SELECT Id FROM Contact');  
            }
            When 'Campaign'{
                campaignId = Database.query('SELECT Id FROM Campaign');
            }
        }
        if(accountsId.size() > 0){
            for(Attachment att : [SELECT Id, Name, Body FROM Attachment WHERE ParentId IN : accountsId]){ 
                System.debug('att => ' + att);
                attachModel.add(new AttachmentCopyModel(att, att.Name.substringAfter('.').toUpperCase()));
            }        
        }else if(contactsId.size() > 0){
            for(Attachment att : [SELECT Id, Name, Body FROM Attachment WHERE ParentId IN : contactsId]){
                attachModel.add(new AttachmentCopyModel(att, att.Name.substringAfter('.').toUpperCase()));
            }
        }else if(campaignId.size() > 0){ 
            for(Attachment att : [SELECT Id, Name, Body FROM Attachment WHERE ParentId IN : campaignId]){
                attachModel.add(new AttachmentCopyModel(att, att.Name.substringAfter('.').toUpperCase()));
            }
        }
    }
    public void attachmentCheck(){
    	Boolean isCheck = true;
        Boolean isButtonEnable = true;
        for(AttachmentCopyModel att : attachModel){
            if(att.check){ 
            	isButtonEnable = false;   
            }else{
            	isCheck = false;     
            }
        }
        copyToButtonHide = isButtonEnable;
        checkAllAttachment = isCheck;
    }
    public void attachmentCheckAll(){
        if(checkAllAttachment == false){
        	copyToButtonHide = true;    
        }else{
            copyToButtonHide = false;
        }
        for(AttachmentCopyModel att : attachModel){
        	att.check = checkAllAttachment;
        }    
    }
    public void assignToCheckAll(){
        if(assignToCheckAll){ 
            for(ObjectDetailsModel obj : objDetails){
                obj.checkDetails = assignToCheckAll;
            }   
        } 
        else{
            for(ObjectDetailsModel obj : objDetails){
                obj.checkDetails = assignToCheckAll; 
            }
        }   
    }
    public void assignToCheck(){
        Boolean check = true;
        for(ObjectDetailsModel obj : objDetails){
            if(obj.checkDetails == false){
                check = false;	    
            }
        } 
        assignToCheckAll = check;  
    }
    public void assignObjectDetails(){
        accountList = new List<Account>();
        contactList = new List<Contact>();
        campaignList = new List<Campaign>();
        objDetails = new List<ObjectDetailsModel>();
        hideDetails = false;
    }
    public void copyTo(){
        Boolean isCheck = false;
        for(AttachmentCopyModel att : attachModel){
            if(att.check){
                isCheck = true;
                attachmentCheckList.add(att.attachmentObj);
            }    
        }
        displayPopup = isCheck;
    }
    public void closePopup(){
        displayPopup = false;
    }
    public void search(){
        hideDetails = true;
        accountList = new List<Account>();
        contactList = new List<Contact>();
        campaignList = new List<Campaign>();
        
        String querySearchName = '%' + searchName + '%';
        String query = 'SELECT Id, Name FROM ';
        switch on assignObject{
            When 'Account'{
                if(String.isNOtBlank(searchName)){
                    query = query + ' Account WHERE Name LIKE : querySearchName';	
                }else{
                    query = query + ' Account';    
                }
                accountList = Database.query(query);
            }
            When 'Contact'{
                if(String.isNOtBlank(searchName)){
                    query = query + ' Contact WHERE Name LIKE : querySearchName';	
                }else{
                    query = query + ' Contact';       
                }
                contactList = Database.query(query);
            }
            When 'Campaign'{
                if(String.isNotBlank(searchName)){
                    query = query + 'Campaign WHERE Name LIKE : querySearchName';
                }else{
                    query = query + ' Campaign';
                }
                campaignList = Database.query(query);
            }
        }
        if(accountList.size() > 0){
            objDetails = new List<ObjectDetailsModel>();
            for(Account acc : accountList){
                objDetails.add(new ObjectDetailsModel(acc));
            }		   
        }
        else if(contactList.size() > 0){
            objDetails = new List<ObjectDetailsModel>();
            for(Contact con : contactList){
                objDetails.add(new ObjectDetailsModel(con));
            }		   
        }
        else if(campaignList.size() > 0){
            objDetails = new List<ObjectDetailsModel>();
            for(Campaign cam : campaignList){
                objDetails.add(new ObjectDetailsModel(cam));
            }
        }
    }
    public PageReference submit(){
        Attachment attObj;
        List<Attachment> attachmentList = new List<Attachment>();
        
        if(assignObject == 'Account'){
            for(ObjectDetailsModel obj : objDetails){
                if(obj.checkDetails){	
                    for(Attachment att : attachmentCheckList){
                        attObj = new Attachment();
                        attObj.Name = att.Name;
                        attObj.Body = att.Body;
                        attObj.ParentId = obj.accObj.Id;
                        attachmentList.add(attObj);              
                    } 
                }    
            }    
        }
        else if(assignObject == 'Contact'){
            for(ObjectDetailsModel obj : objDetails){
                if(obj.checkDetails){
                    for(Attachment att : attachmentCheckList){
                        attObj = new Attachment();
                        attObj.Name = att.Name;
                        attObj.Body = att.Body;
                        attObj.ParentId = obj.conObj.Id;
                        attachmentList.add(attObj); 
                    }
                }
            }    
        }
        else if(assignObject == 'Campaign'){
            for(ObjectDetailsModel obj : objDetails){
                if(obj.checkDetails){
                    for(Attachment att : attachmentCheckList){
                        attObj = new Attachment(); 
                        attObj.Name = att.Name;
                        attObj.Body = att.Body;
                        attObj.ParentId = obj.camObj.Id;
                        attachmentList.add(attObj);
                    }
                }
            }    
        }
        Insert attachmentList;
        
        PageReference pg = new PageReference('/apex/AttachmentCopyPage');
        pg.setRedirect(true);
        return pg;
    }
    public class AttachmentCopyModel{
        public Attachment attachmentObj {get;set;}
        public Boolean check {get;set;}
        public String extension {get;set;}
        
        public AttachmentCopyModel(Attachment attachmentObj, String extension){
            this.attachmentObj = attachmentObj;
            this.extension = extension;
        }
    }
    public class ObjectDetailsModel{
        public Account accObj {get;set;}
        public Contact conObj {get;set;}
        public Campaign camObj {get;set;}
        public Boolean checkDetails {get;set;}
        
        public ObjectDetailsModel(Account accObj){
            this.accObj = accObj;
        }
        public ObjectDetailsModel(Contact conObj){
            this.conObj = conObj;
        }
        public ObjectDetailsModel(Campaign camObj){
            this.camObj = camObj;
        }
    }
}