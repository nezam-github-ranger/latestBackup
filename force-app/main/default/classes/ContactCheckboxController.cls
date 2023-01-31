public class ContactCheckboxController {
    public List<Contact> conList {get;set;}
    public List<ContactModel> modelList{get;set;} 
    public String deletedId {get;set;}
    public List<Contact> deletedList {get;set;}
    public Boolean checkAll {get;set;}
    public String cloneId {get;set;}
    public Contact cloneRecord {get;set;}
    public Boolean cloneShow {get;set;}
   	public Integer srNo {get;set;}
    public Integer numberOfRows {get;set;}
    public Integer startingRows {get;set;}
        
    public ContactCheckboxController(){
        checkAll = false;
        srNo = 1;
        numberOfRows = 15;
        startingRows = 0;
        conList = new List<Contact>();
        modelList = new List<ContactModel>();
        conList = [SELECT Id, FirstName, LastName, Name, Phone, Email, Fax FROM Contact];
        
        for(Contact c : conList){
            modelList.add(new ContactModel(c,false,srNo++));
        }        
    }
    public PageReference save(){
        deletedList = new List<Contact>();
    	List<Contact> updateList = new List<Contact>();
        for(ContactModel upList : modelList){
            if(upList.check){
                updateList.add(upList.conObj);
            }
        }
        if(deletedList.size() > 0){
            delete deletedList;
        }
        System.debug('Before Insert clone => ' + cloneRecord);
        if(cloneRecord != Null){
            insert cloneRecord;
            System.debug('After Insert clone ==> ' + cloneRecord);
        }
        upsert updateList;
        PageReference pg = new PageReference('/apex/ContactCheckboxPage');
        pg.setRedirect(true);
        return pg;
    }
    public PageReference cancel(){
      	 PageReference pg = new PageReference('/apex/ContactCheckboxPage');
         pg.setRedirect(true);
         return pg;
    }
    
    public void deleteClicked(){
        deletedList = new List<Contact>();
        Integer deletedIndex;
        
        System.debug('delete ==> ' + deletedId );
        //Set<String> deletedIds = deletedId;
        for(ContactModel cm : modelList){
            if(cm.conObj.Id == deletedId){
          		deletedList.add(cm.conObj);
                deletedIndex = modelList.indexOf(cm);
                System.debug('Index => ' + deletedIndex);
            }
        }  
        modelList.remove(deletedIndex);
    }
    
    public void checkboxAllSelect(){
        for(ContactModel modelObj : modelList){
        	modelObj.check = checkAll;
        }
    }
     public void checkboxSelect(){
        System.debug('checkbox select  => ' + checkAll);
        Boolean bool = false;
        if(checkAll){
        	for(ContactModel modelObj : modelList){     
                if(modelObj.check == bool){
                    checkAll = bool;
                }
            }    
        }else{
            bool = true;
         	for(ContactModel modelObj : modelList){     
                if(modelObj.check == false){
                    bool = false;
                    break;
                }
            }
            checkAll = bool;
         }
    }
    public void createClone(){
        cloneShow = true;
    	System.debug('clone Id ==> ' + cloneId);
        cloneRecord = new Contact();
        for(ContactModel cm : modelList){
            if(cm.conObj.Id == cloneId){
                cloneRecord.FirstName = cm.conObj.FirstName;
                cloneRecord.LastName = cm.conObj.LastName;
                cloneRecord.Email = cm.conObj.Email;
                cloneRecord.Phone = cm.conObj.Phone;
            }    
		}
        System.debug('cloneRecord  ==> ' + cloneRecord);
    }
    public PageReference saveClone(){ 
        
        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter value'));
        cloneShow = false;
        PageReference pg = new PageReference('/apex/ContactCheckboxPage');
        pg.setRedirect(true);
        return pg;
    }
    public void first(){
    	numberOfRows = 15;
        startingRows = 0;
    }
    public void next(){
        if(startingRows + 15 < modelList.size()){
        	startingRows += numberOfRows;
		}   
        
    }
    public void previous(){
        numberOfRows = 15;
        if(startingRows > 0){
        	startingRows -= numberOfRows;
        }
    }
    public void last(){
        numberOfRows = math.mod(modelList.size(), 15);      
        startingRows = modelList.size() - numberOfRows;
    }
    
    public class ContactModel{
        public Contact conObj {get;set;}
        public Boolean check {get;set;}
        public Integer serialNo {get;set;}

        public ContactModel(Contact conObj, Boolean check, Integer serialNo){
			this.conObj = conObj;
			this.check = check; 
            this.serialNo = serialNo;
        }
    }    
}