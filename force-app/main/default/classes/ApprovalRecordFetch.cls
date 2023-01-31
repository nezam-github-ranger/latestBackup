public class ApprovalRecordFetch {
   
    @AuraEnabled(cacheable=true)
    public static List<ProcessInstanceWorkItem> fetchProcessInstance(){
        System.debug('current user id ==> ' + UserInfo.getUserId());
        System.debug('Query Debug ==> ' + [SELECT Id, Actor.Name, OriginalActor.Name, ProcessInstance.CreatedDate, 
                                           ProcessInstance.Status, ProcessInstance.SubmittedBy.Name, 
                                           ProcessInstance.TargetObject.Name, ProcessInstance.TargetObject.Type 
                                           FROM ProcessInstanceWorkItem WHERE ActorId =: UserInfo.getUserId()]);
        return [SELECT Id, Actor.Name, OriginalActor.Name, ProcessInstance.CreatedDate, ProcessInstance.Status, 
                ProcessInstance.SubmittedBy.Name, ProcessInstance.TargetObject.Name, ProcessInstance.TargetObject.Type 
                FROM ProcessInstanceWorkItem WHERE ActorId =: UserInfo.getUserId()];
    }
    
    @AuraEnabled(cacheable=true)
    public static List<User> lookupFilter(String relatedUser){
        relatedUser = '%' + relatedUser + '%';
      	System.debug('relatedUser ==> ' + relatedUser);
        
        List<User> relatedUsers = [SELECT Id, Name FROM User WHERE Name LIKE: relatedUser];
        System.debug('relatedUsers ==> ' + relatedUsers);
        return relatedUsers;
    }

}