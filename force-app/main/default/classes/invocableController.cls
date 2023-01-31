public class invocableController {
    
    @InvocableMethod(label = 'This is my label'
                     description = 'This is my description'
                     category = 'Opportunity'
                    )
    public static void deleteOpportunity(List<String> opportunityIds){
        
        List<Opportunity> listOpportunity = [SELECT Id, Name FROM Opportunity WHERE Id IN: opportunityIds];
        if(listOpportunity.size() > 0){
            DELETE listOpportunity;
        }
    }

}