public class AccountOpportunityController {
    public List<Opportunity> opportunityList {get;set;}
    
    public AccountOpportunityController(){
    	opportunityList = new List<Opportunity>();
        Id opportunityId = ApexPages.currentPage().getParameters().get('Id');
        if(String.isNotBlank(opportunityId)){
        	opportunityList = [SELECT AccountId, Name, Type, LeadSource, Amount FROM Opportunity WHERE Id =: opportunityId];
        }
    }
}