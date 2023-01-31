global class ProjectDeployementEmailSchedule implements Schedulable {
    
    global void execute(SchedulableContext sc){
    	Database.executeBatch(new ProjectDeploymentEmailBatch());	  
    }
}