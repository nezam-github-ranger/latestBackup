public class AddMultipleAccountController {
    public List<Booking__c> ListAccount{get; set;}
    
    public AddMultipleAccountController(){
        ListAccount = new List<Booking__c>();
        ListAccount.add(new Booking__c());
    }

    public void addAccount(){
        ListAccount.add(new Booking__c());
    }

    public PageReference saveAccount(){
        insert ListAccount;
        PageReference pg = new PageReference('/apex/BookingAddListPageDynamic');
        pg.setRedirect(true);
        return pg;
    }
}