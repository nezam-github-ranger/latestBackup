public class AccountCaseController {
    public List<Case> caseList {get;set;}
    public AccountCaseController(){
        caseList = new List<Case>();
        Id caseId = ApexPages.currentPage().getParameters().get('Id');
        if(caseId != Null){
        	caseList = [SELECT AccountId, Type, Status, Reason, Origin FROM Case WHERE Id =: caseId];
        }			
    }
}