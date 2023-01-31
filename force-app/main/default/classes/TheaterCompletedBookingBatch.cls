public class TheaterCompletedBookingBatch implements Database.Batchable<sObject>, Database.Stateful {
    public Database.QueryLocator start(Database.BatchableContext bc){
        DateTime currentDateTime = System.now();
        Time currentTime = currentDateTime.time();
        System.debug('current Time  ==> ' + currentTime);
        System.debug('date ==> ' + Date.parse(system.today().format()));
                
        return Database.getQueryLocator([SELECT Booking_Date__c, Show_Time__c, Status__c FROM Seat_Booking__c WHERE Status__c != 'Completed' AND Booking_Date__c =: Date.parse(system.today().format()) AND Show_Time__c <=: currentTime]);
    }
	    
	public void execute(Database.BatchableContext bc, List<Seat_Booking__c> seatBookingList){
    	System.debug('seatBookingList => ' + seatBookingList);
        for(Seat_Booking__c booking : seatBookingList){
            booking.Status__c = 'Completed';
            System.debug('booking ==> ' + booking);
        }
        System.debug('updated seatBookingList => ' + seatBookingList);
        Update seatBookingList;
    }
    
    public void finish(Database.BatchableContext bc){
    	System.debug('finish method call');		    
    }
}