trigger OpportunityTrigger on Opportunity (before insert, before update) {
    List<Opportunity> opportunityList = trigger.new;
    List<Id> opportunityIds = new List<Id>();
    for(Opportunity opp : opportunityList){
        opportunityIds.add(opp.AccountId);
    }
    List<Account> accountList = [SELECT Id, Account_Type__c, Name FROM Account WHERE Id IN : opportunityIds];
    Map<Id, Account> accountMap = new Map<Id, Account>();
    for(Account acc : accountList){
        accountMap.put(acc.id, acc);
    }
    
    if(trigger.isInsert){
        for(Opportunity opp : opportunityList){
            Account acc = accountMap.get(opp.AccountId);
            if(acc.Account_Type__c == 'Reseller'){
                opp.Stage_Type__c = '10';              
            }
            else if(acc.Account_Type__c == 'Current Customer'){
                opp.Stage_Type__c = '100';      
            }
            else if(acc.Account_Type__c == 'Buyer'){
                opp.Stage_Type__c = '25';   
            }
            else{
                opp.Stage_Type__c = '0';   
            }
        }
    }
    List<Account> accList = new List<Account>();
    Boolean helperBoolean;
    if(trigger.isUpdate){
        for(Opportunity opp : opportunityList){
            Account acc = accountMap.get(opp.AccountId);
            if(opp.Stage_Type__c == '0' || opp.Stage_Type__c == '10'){
                acc.Account_Type__c = 'Reseller';       
            } 
            else if(opp.Stage_Type__c == '25'){
                acc.Account_Type__c = 'Buyer';      
            }
            else if(opp.Stage_Type__c == '100'){
                acc.Account_Type__c = 'Current Customer';       
            }
            accList.add(acc);
        }
        helperBoolean = OpportunityUpdateController.makeTrue;
    }
    if(!OpportunityUpdateController.makeTrue){
         OpportunityUpdateController.makeTrue= true;
        update accList;
        
    }
    
}