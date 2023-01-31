public class ManageApprovalButton {
    
    //-------------------------- approve and reject handle method ----------------------------------
    @AuraEnabled(cacheable = false)
    public static void manageCustomApproval(String workItemId, String approvalAction, String comment){
        System.debug('workItemId ==> ' + workItemId);
        System.debug('approvalAction ==> ' + approvalAction);
        if(String.isNotBlank(workItemId)){
            ProcessInstanceWorkitem workItem = [SELECT Id, ActorId FROM ProcessInstanceWorkitem 
                                                WHERE Id =: workItemId];
            
            Approval.ProcessWorkItemRequest pwr = new Approval.ProcessWorkItemRequest();
            if(String.isNotBlank(approvalAction)){
                pwr.setAction(approvalAction);    
            }
            if(String.isNotBlank(comment)){
                pwr.setComments(comment);   
            }
            pwr.setWorkItemId(workItem.id);
            Approval.ProcessResult result = Approval.process(pwr);
            System.debug('workItems ==> ' + workItem);
        }
    }
    
    //-------------------------- reassign handle method ----------------------------------
    @AuraEnabled(cacheable = false)
    public static void reassignApprovalUser(String workItemId, String userToAssign){
        System.debug('reassign call');
        System.debug('workItemId ==> ' + workItemId);
        System.debug('user to assign ==> ' + userToAssign);
        
        if(String.isNotBlank(userToAssign) && String.isNotBlank(workItemId)){
            ProcessInstanceWorkitem workItem = [SELECT Id, ActorId FROM ProcessInstanceWorkitem 
                                                WHERE Id =: workItemId];
            System.debug('workItems ==> ' + workItem);
            workItem.ActorId = userToAssign;
            Update workItem;
            System.debug('workitem ==> ' + workItem);
        }
    } 
    
    //-------------------------- all approval request fetch ----------------------------------
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
    
    //-------------------------- custom lookup fetch records ----------------------------------
    @AuraEnabled(cacheable=true)  
    public static List<sobject> findRecords(String searchKey, String objectName) {  
        string searchText = '\'' + String.escapeSingleQuotes(searchKey) + '%\'';  
        string query = 'SELECT Id, Name FROM ' +objectName+ ' WHERE Name LIKE '+searchText+' LIMIT 6';  
        return Database.query('SELECT Id, Name FROM ' +objectName+ ' WHERE Name LIKE '+searchText+' LIMIT 6');  
    }  
    
}