public class BookingDetails {
	
    public Booking__c booking {get;set;}
	public BookingDetails(){
        String bid = ApexPages.currentPage().getParameters().get('bid');
        if(String.isNotBlank(bid)){
            booking = [SELECT Name,Email__c,RoomNo__c,Status__c,Amount__c,Check_In_Time__c,Check_Out_Time__c,Customer__c from Booking__c Where id =: bid];
        }else{
            booking = new Booking__c();
        }
    } 
    public PageReference save(){
         try {
            Upsert booking;
            PageReference pg = new PageReference('/' + booking.Id);    
            return pg;
        }
        catch(Exception e) {
            Apexpages.addMessages(e);
            return NULL;
        }
    }
     public PageReference SaveAndNew(){
        upsert booking;	
		PageReference pg = new PageReference('/apex/bookingAddPage');   
        pg.setRedirect(true);
        return pg;
    }
    
}