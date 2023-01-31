/*
    Name	 	:  TheaterSeatCategoryDetails 
	Project     :  Book My Show
    Date 		:  29 April, 2021
    Author 		:  Nezam Uddin
    Description :  This class is used to fetch all the seats and categories of the particular selected movie.
*/

public without sharing class TheaterSeatCategoryDetails {

    @AuraEnabled(cacheable = true)	
    public static List<Seat_Categories__c> fetchSeatCategoryDetails(){
        return [SELECT Name, Price__c, (SELECT Name FROM Seats__r)  FROM Seat_Categories__c];
    }
    
    @AuraEnabled(cacheable = true)
    public static List<Booking_Line_Item__c> fetchSelectedSeats(String selectedMovieId){
        System.debug('selectedMovieId' + selectedMovieId);
       	Set<Id> bookingIds = new Set<Id>();
        List<Seat_Booking__c> seatBooking = new List<Seat_Booking__c>([SELECT Id FROM Seat_Booking__c WHERE Movie__c =: selectedMovieId]);
        for(Seat_Booking__c seat : seatBooking){
        	bookingIds.add(seat.Id);   
        }
        return [SELECT Seat__r.Name, Seat_Category__r.Name, Booking__r.Name FROM Booking_Line_Item__c WHERE Booking__c IN: bookingIds];	
    }
}