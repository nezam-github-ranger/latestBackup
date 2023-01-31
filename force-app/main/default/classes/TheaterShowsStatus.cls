/*
    Name	 	:  TheaterShowsStatus 
	Project     :  Book My Show
    Date 		:  29 April, 2021
    Author 		:  Nezam Uddin
    Description :  This class is used to fetch all the seat booking status.
*/
public class TheaterShowsStatus {

    @AuraEnabled(cacheable = true)
    public static List<Seat_Booking__c> fetchShowsStatus(){
        return [SELECT Id, Total_Amount__c, Total_Seat__c, Status__c FROM Seat_Booking__c];
        
    }
    
}