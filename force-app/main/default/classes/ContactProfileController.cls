public class ContactProfileController {
	public List<Attachment> attachmentList {get;set;}
    public Attachment attachmentObj {get;set;}
    
    public ContactProfileController(ApexPages.StandardController sc){
        attachmentList = new List<Attachment>();   
        Id contactId = sc.getId();
        
        attachmentObj = new Attachment(ParentId = contactId);
        
    	attachmentList = [SELECT Id, ParentId FROM Attachment WHERE ParentId =: contactId AND (Name Like '%jpg' OR Name Like '%png')  ORDER BY CreatedDate Desc Limit 1];  
			
		//System.debug('id ==> ' + attachmentlist);        
        //System.debug('size ==> ' + attachmentlist.size());
    }
    public void upload(){
       System.debug('attachmentObj ==> ' + attachmentObj);
        if(attachmentObj.Name.Contains('.')){
            String fileExtension = attachmentObj.Name.substringAfter('.');
            if(fileExtension != 'jpg' && fileExtension != 'png'){
            		    
            }
        }
       insert attachmentObj;
    }
}