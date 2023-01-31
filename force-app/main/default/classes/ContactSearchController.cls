/*
Name	 	:  ContactSearchController
Date 		:  01 March, 2021
Author 		:  Nezam Uddin
Description :  This is a Controller of contact list. In this controller we show all the contacts, we also doing search work, and update the type field of contact. I also pagination for all the details if user choose any page size then automatically page size is updated and when click on first, next, last, previous button then all the data are show according to presses button.

*/
public class ContactSearchController {
    public String inputText {get;set;} 
    public List<ContactModel> contactModelList {get;set;}
    private List<Contact> contactList;
    
    public List<SelectOption> selectOptions {get;set;}
    public String selectedValue {get;set;}
    
    public List<SelectOption> numberOfRecordOptions {get;set;}
    public Integer selectedNumberOfRecord {get;set;}
    
    public String selectedField {get;set;}
    public String sortDirection {get;set;}
    Integer count;
    
    public Boolean isLastButtonDisabled {get;set;}
    public Boolean isPrevButtonDisabled {get;set;}
    public Boolean isFirstButtonDisabled {get;set;}
    public Boolean isNextButtonDisabled {get;set;}
    
    public ContactSearchController(){
        contactModelList = new List<ContactModel>();
        contactList = new List<Contact>();
        selectOptions = new List<SelectOption>();
        numberOfRecordOptions = new List<SelectOption>();
        
        selectOptions.add(new SelectOption('','--None--'));
        selectedNumberOfRecord = 4; 
        sortDirection = 'ASC';
        
        count = 0;        
        search();
        addSelectOptions();
    }
    
    /*-------------- This is the getter of selectoption type in this getter method all the contact type field values are added in list.  -----------*/
    public List<SelectOption> getSelectTypeOptions(){
        if(selectOptions.size() <= 1){
            Schema.DescribeFieldResult fieldResult = Contact.Type__c.getDescribe();
            List<Schema.PicklistEntry> pickListValues = fieldResult.getPicklistValues();
            for(Schema.PicklistEntry pick : pickListValues){
                selectOptions.add(new SelectOption(pick.getLabel(), pick.getValue()));
            }
        }
        return selectOptions;
    }
    
    /*-------------------- search method is used to show all the details in first time but when user input some value and then search then only search related data are shown (searching are apply on the basis of name and email) --------- */
    
    public void search(){  
        contactModelList.clear();
        String query = 'SELECT Name, Email, AccountId, Phone, Type__c, Details__c FROM Contact';
        if(String.isNotBlank(inputText)){
            String searchVal = '%' + inputText + '%';
            query += ' WHERE Name Like \'' + searchVal + '\' OR Email Like \'' + searchVal + '\'';
        }
        if(String.isNotBlank(selectedField)){ 
            query += ' ORDER BY ' + selectedField + ' ' + sortDirection;   
        }	
        
        
        contactList = Database.query(query + ' Limit 100');
        if(selectedNumberOfRecord > contactList.size()){
            isLastButtonDisabled = true;
            isPrevButtonDisabled = true;
            isFirstButtonDisabled = true;
            isNextButtonDisabled = true;    
        }
        else{
        	isLastButtonDisabled = false;
            isNextButtonDisabled = false;   
            isPrevButtonDisabled = true;
            isFirstButtonDisabled = true;
        }
        if(contactList.size() > 0){
            for(Integer i = 0; i < contactList.size() - 1; i++){
                Contact con = contactList.get(i);
                contactModelList.add(new ContactModel(con));
                if(selectedNumberOfRecord <= i){
                    break;
                }
            }
        }
        
        sortDirection = sortDirection.equals('ASC') ? 'DESC' : 'ASC';
        
        if(contactList.size() < 1){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No Results Found'));
        }
    }
    /*------------- save method is used to save the update value of type field. ---------------*/
    public void save(){
        List<Contact> contactUpdatedList = new List<Contact>();
        for(ContactModel conModel : contactModelList){
            if(conModel.isChecked){
                conModel.contactObj.Type__c = selectedValue;
                contactUpdatedList.add(conModel.contactObj);
            }
        }
        Update contactUpdatedList;
    }
    
    /*--------------- This is addSelectOptions method this method is used to add number of records option in list. ------------*/
    public void addSelectOptions(){
        for(Integer fill = 1; fill < 5; fill++){
            numberOfRecordOptions.add(new SelectOption(String.valueOf(fill*5), String.valueOf(fill*5)));
        }
    }
    
    /*----------------- This showRecord method is used to show particular records that are selected by selectlist. ------------------*/
    public void showRecord(){
        contactModelList.clear();
        for(Integer i = 0; i < selectedNumberOfRecord; i++){
            if(contactList.size() <= i){
                break;    
            }
            Contact con = contactList.get(i);
            contactModelList.add(new ContactModel(con));
        }
    }
    
    /*--------------  This first method is used to show first five record of the list, but when user chooses any options of the selectlist option of then data show according the selected options . ----------*/
    public void first(){
        isLastButtonDisabled = false;
        isNextButtonDisabled = false;
        isPrevButtonDisabled = true;
        isFirstButtonDisabled = true;     
        contactModelList.clear();
        
        for(count = 0; count < selectedNumberOfRecord; count++){
            Contact con = contactList.get(count);
            contactModelList.add(new ContactModel(con));
        }    	
    }
    
    /*---------------- This previous method is used to show previous data according to the selected options. -------------------*/    
    public void previous(){
        isLastButtonDisabled = false;
        isNextButtonDisabled = false;
        contactModelList.clear();
     
        count -= selectedNumberOfRecord;
        if(count > 0){
            for(Integer i = count; i < count + selectedNumberOfRecord; i++){
                Contact con = contactList.get(i);
                contactModelList.add(new ContactModel(con));
            } 
    	}
        else{
        	for(Integer i = 0; i < selectedNumberOfRecord; i++){
                Contact con = contactList.get(i);
                contactModelList.add(new ContactModel(con));
            } 
            isPrevButtonDisabled = true;
            isFirstButtonDisabled = true;
        }
    }
    
    /*-----------------  This next method is used to show next data according to the selected options .  ---------------*/
    public void next(){
        
        count += selectedNumberOfRecord;
        if(count + selectedNumberOfRecord < contactList.size()){
            contactModelList.clear();
            for(Integer i = count; i < count + selectedNumberOfRecord && count < contactList.size(); i++){
                Contact con = contactList.get(i);
                contactModelList.add(new ContactModel(con));
            }
            isPrevButtonDisabled = false;
       		isFirstButtonDisabled = false;
        }
        else{
            contactModelList.clear();
            for(Integer i = count; i < contactList.size(); i++){
                Contact con = contactList.get(i);
                contactModelList.add(new ContactModel(con));
            }
            isLastButtonDisabled = true;
            isNextButtonDisabled = true;
        }
    } 
    
    /*--------------- Last method is used to show last data according to the selected options. ----------------*/
    public void last(){
        isLastButtonDisabled = true;
        isPrevButtonDisabled = false;
        isFirstButtonDisabled = false;
        isNextButtonDisabled = true;
        contactModelList.clear();
        count = contactList.size() - selectedNumberOfRecord ;
        for(Integer i = count; i < contactList.size() ; i++){
            Contact con = contactList.get(i);
            contactModelList.add(new ContactModel(con));
        }	
    }
    public Class ContactModel{
        public Contact contactObj {get;set;} 
        public Boolean isChecked {get;set;}
        
        public ContactModel(Contact contactObj){
            this.contactObj = contactObj;		 		    
        }
    } 
}