global class TheaterCompletedBookingSchedule implements Schedulable {

    global void execute(SchedulableContext sc){
    	Database.executeBatch(new TheaterCompletedBookingBatch());
    }
}