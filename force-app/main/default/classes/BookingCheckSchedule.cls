public class BookingCheckSchedule implements Schedulable {

    public void execute(SchedulableContext sc){
    	new CheckAllBookingAsCompletedBatch();   
    }
}