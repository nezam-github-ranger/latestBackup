public class UpdateContactMailingAddressController {
	public List<SelectOption> accountOptions {get;set;}
    public String selectedAccount {get;set;}
    public Account accountObj {get;set;}
    public Boolean show{get;set;}
    public List<Contact> contactList {get;set;}
    
    public UpdateContactMailingAddressController(){
   		accountOptions = new List<SelectOption>();
        List<Account> accList = [SELECT Id, Name FROM Account];
		accountObj = new Account();  
        
        for(Account ac : accList){
            accountOptions.add(new SelectOption(ac.Id, ac.Name));
        }
    }
    public void loadCountryDetails(){
    	show = true;  
        accountObj = [SELECT Id, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry FROM Account WHERE Id =: selectedAccount];
    }
    public void Submit(){
     	//System.debug('accountObj ==> ' + accountObj); 
     	contactList = new List<Contact>();
		contactList = [SELECT Id, Name FROM Contact WHERE AccountId =: selectedAccount];
        
        System.debug('contactList ==> ' + contactList);
      	if(contactList.size() > 0){
            for(Contact con : contactList){
                //con.Name = accountObj.Name;
            	con.MailingStreet = accountObj.BillingStreet;
                con.MailingCity = accountObj.BillingCity;
                con.MailingState = accountObj.BillingState;
                con.MailingPostalCode = accountObj.BillingPostalCode;
                con.MailingCountry = accountObj.BillingCountry;
            }
        }
        upsert contactList;
        
    }
}