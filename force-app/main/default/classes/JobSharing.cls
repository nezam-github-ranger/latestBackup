public class JobSharing {
    public static boolean manualShareRead(Id recordId, Id userOrGroupId){
        Class__Share jobShr  = new Class__Share();
        jobShr.ParentId = recordId;
        jobShr.UserOrGroupId = userOrGroupId;
        jobShr.AccessLevel = 'Read';
        jobShr.RowCause = Schema.Class__Share.RowCause.Manual;
        System.debug('jobShr ==> ' + jobShr);
        Database.SaveResult sr = Database.insert(jobShr,false);
        if(sr.isSuccess()){
            return true;
        }
        else {
            Database.Error err = sr.getErrors()[0];
            System.debug('err ==> ' + err);
            if(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  &&  
               err.getMessage().contains('AccessLevel')){
                   return true;
               }
            else{
                return false;
            }
        }
    }
}