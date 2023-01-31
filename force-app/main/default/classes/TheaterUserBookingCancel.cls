/*
    Name	 	:  TheaterUserBookingCancel
	Project     :  Book My Show
    Date 		:  29 April, 2021
    Author 		:  Nezam Uddin
    Description :  This class is called when user cancel any seats. All the cancel seats work are doing in this class.
*/
public class TheaterUserBookingCancel {

    @AuraEnabled
    public static Boolean userBookingCancel(String bookingId){
        DateTime currentDateTime = System.now();
        Time currentTime = currentDateTime.time();
        String userId = userInfo.getUserId();

        Seat_Booking__c seatBooking = [SELECT Id, Booking_Date__c, Show_Time__c, Status__c, Movie__c FROM Seat_Booking__c WHERE Id =: bookingId];
        if(seatBooking.Booking_Date__c == Date.parse(system.today().format()) && seatBooking.Show_Time__c <= currentTime){
            return true;
        }
        else{
            seatBooking.Status__c = 'Canceled';
            seatBooking.Cancel_Reason__c = 'Cancel Seat';
            System.debug('seat booking ==> ' + seatBooking);
            Update seatBooking;
            return false;
        }
	}
}