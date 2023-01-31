public class BookingDetailListController {

    public List<Booking__c> bookings{get;set;}
    public BookingDetailListController(){
        bookings = [SELECT Name,Customer__c,Email__c,RoomNo__c,Status__c,Total_Hours__c,Amount__c,Check_In_Time__c,Check_Out_Time__c From Booking__c];
    }
}