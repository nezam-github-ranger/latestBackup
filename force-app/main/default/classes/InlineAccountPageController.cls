public class InlineAccountPageController {   
    public List<InlineModel> contactModelList {get;set;}
    public List<InlineModel> allContactModelList {get;set;}
    public Contact contact;
    public String accountId;
    public Integer totalNumberOfContact {get;set;}
    public Integer totalNumberOfAccountContact {get;set;}
    public Boolean checkAllContacts {get;set;}
    public Boolean checkAllAccountContacts {get;set;}
    public Boolean bool;
        
    public InlineAccountPageController(ApexPages.StandardController sc){
        contactModelList = new List<InlineModel>();
        allContactModelList = new List<InlineModel>();
        accountId = sc.getId();
        contact = new Contact(AccountId = accountId);
        checkAllAccountContacts = false;
        checkAllContacts = false;
       
        for(Contact con : [SELECT Id, Name, AccountId FROM Contact WHERE AccountId =: accountId]){
            contactModelList.add(new InlineModel(con));
        }
        
        for(Contact con : [SELECT Id, Name, AccountId FROM Contact WHERE AccountId != : accountId]){
            allContactModelList.add(new InlineModel(con, true));
        }
        totalNumberOfAccountContact = totalAccountContact(); 
        totalNumberOfContact = totalContact();
    }
    public Integer totalAccountContact(){
        return contactModelList.size();
    }
    public Integer totalContact(){
        return allContactModelList.size(); 
    }
    public void remove(){
        for(Integer i = contactModelList.size(); i >= 0; i--){
            InlineModel model = contactModelList.get(i);
            if(model.contactCheckbox){
            	allContactModelList.add(new InlineModel(model.contactObj, true));	  
                contactModelList.remove(i);
            }
        }
        totalNumberOfAccountContact = totalAccountContact();
        totalNumberOfContact = totalContact();
    }
    public void add(){
        for(Integer i = allContactModelList.size() - 1; i >= 0; i--){
            InlineModel model = allContactModelList.get(i);
           	if(model.contactCheckbox){
                contactModelList.add(new InlineModel(model.contacts));
                allContactModelList.remove(i);       
            }       
        }
        totalNumberOfAccountContact = totalAccountContact();
        totalNumberOfContact = totalContact();
    }
    public void submit(){
        List<Contact> insertList = new List<Contact>();
        for(InlineModel model : contactModelList){  
            if(model.contactObj.AccountId == Null){
                model.contactObj.AccountId = accountId;
                insertList.add(model.contactObj);
            }
        } 
        Upsert insertList;
        insertList = new List<Contact>();
        for(InlineModel model : allContactModelList){
            if(model.contacts.AccountId != Null){
           		model.contacts.AccountId = Null;
                insertList.add(model.contacts);
            }
        }
        Upsert insertList;
    }
    public void checkboxAllAccountSelect(){
        for(InlineModel model : contactModelList){
            model.contactCheckbox = checkAllAccountContacts;
        }	    
    }
    public void checkboxAllSelect(){
        for(InlineModel model : allContactModelList){
        	model.contactCheckbox = checkAllContacts;   
        }   
    }
    public void checkboxSingleAccountSelect(){
        bool = true;
        if(checkAllAccountContacts){
            for(InlineModel model : contactModelList){
                if(model.contactCheckbox == false){
                    checkAllAccountContacts = false;    
                }     
            }
        }else{
            for(InlineModel model : contactModelList){
                if(model.contactCheckbox == false){
                	bool = false;	
                }
            }
            checkAllAccountContacts = bool;
        }
    }
    public void checkboxSingleSelect(){
    	bool = true;
        if(checkAllContacts){
            for(InlineModel model : allContactModelList){
                if(model.contactCheckbox == false){
                	checkAllContacts = false;    
                }
            }
        }else{
            for(InlineModel model : allContactModelList){
                if(model.contactCheckbox == false){
                	bool = false;    
                }
            }
            checkAllContacts = bool;
        }
    }
    
    public class InlineModel{
        public Contact contactObj {get;set;}
        public Contact contacts {get;set;}
        public Boolean contactCheckbox {get;set;}
        
        public InlineModel(Contact contactObj){
        	this.contactObj = contactObj;  
        }
        public InlineModel(Contact contacts, Boolean temp){
        	this.contacts = contacts;
        }
    }
}