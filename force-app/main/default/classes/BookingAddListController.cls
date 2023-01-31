public class BookingAddListController {
    public Booking__c bookings1{get;set;}
    public Booking__c bookings2{get;set;}
    public Booking__c bookings3{get;set;}
    
        public BookingAddListController(){
            bookings1 = new Booking__c();
            bookings2 = new Booking__c();
            bookings3 = new Booking__c();
            
        }
        public void save(){	
           Booking__c [] arrayOfProducts = new List<Booking__c>();

            arrayOfProducts.add(bookings1);
            arrayOfProducts.add(bookings2);
            arrayOfProducts.add(bookings3);
                
            for(Booking__c element : arrayOfProducts){
                try{
            		upsert element;
            	}catch(Exception e){
            		Apexpages.addMessages(e);
            	}
            }
            /*try{
            	upsert bookings1;
            }catch(Exception e){
            	Apexpages.addMessages(e);
            }
            try{
            	upsert bookings2;
            }catch(Exception e){
            	Apexpages.addMessages(e);
            }
            try{
            	upsert bookings3;
            }catch(Exception e){
            	Apexpages.addMessages(e);
            }*/
        }
}