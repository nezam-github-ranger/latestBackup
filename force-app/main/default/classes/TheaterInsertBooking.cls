/*
    Name	 	:  TheaterInsertBooking 
	Project     :  Book My Show
    Date 		:  29 April, 2021
    Author 		:  Nezam Uddin
    Description :  This class is used to insert the bookings and also insert the booking line items record.
*/

public without sharing class TheaterInsertBooking {

    @AuraEnabled
    public static String insertRecord(Seat_Booking__c bookingInsert, List<Booking_Line_Item__c> selectedSeat){
        try{
            System.debug('selecteSeat ==> ' + selectedSeat);
            Movies__c movieObject = [SELECT Id, Start_Time__c FROM Movies__c WHERE Id =: bookingInsert.Movie__c];
            bookingInsert.Show_Time__c = movieObject.Start_Time__c;
            bookingInsert.Status__c = 'Upcoming';
            
            System.debug('bookingInsert ==> ' + bookingInsert);
            Insert bookingInsert; 
            
            for(Booking_Line_Item__c bookingObject : selectedSeat){
                bookingObject.Booking__c = bookingInsert.Id;
            }
            
            insert selectedSeat; 
            return 'Record Successfully Inserted!';
        }
        catch(exception e){
            return e.getMessage()+' at line '+e.getLineNumber();
        }
    }
}