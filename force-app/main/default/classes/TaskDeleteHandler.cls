public class TaskDeleteHandler {

    public static void validateDeletedRecord(List<Task> taskList){
        
        if([Select Id, Name FROM Profile WHERE Id =: userinfo.getProfileId()].Name != 'System Administrator'){
            for(Task tsk : taskList){
            	tsk.addError('You dont have permission to delete records...!!');    
            }
        }
    }
}