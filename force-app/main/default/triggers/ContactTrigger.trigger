trigger ContactTrigger on Contact (after insert){//(before insert, before update, after undelete, after insert, after update) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        List<Account> accountList = new List<Account>();
        Set<Id> accountIds = new Set<Id>();
        for(Contact con : Trigger.new){
            accountIds.add(con.AccountId);
        }
        Map<Id, List<Contact>> accountIdAndListOfContact = new Map<Id, List<Contact>>();
        for(Contact con: [SELECT Id, AccountId FROM Contact WHERE AccountId IN: accountIds]){
            List<Contact> tempContact;
            if(!accountIdAndListOfContact.containsKey(con.AccountId)){
                tempContact = new List<Contact>(); 			    
            }
            tempContact = accountIdAndListOfContact.get(con.AccountId);
            accountIdAndListOfContact.put(con.AccountId, tempContact);
            
        }
        System.debug('accountIdAndListOfContact ==> ' + accountIdAndListOfContact);
        /*
        System.debug('accountIds ==> ' + accountIds);
        Map<Id, Account> mapOfAccountIds = new Map<Id, Account>([SELECT Id, Name, Student_Layout_Number__c, Contact_Layout_Number__c FROM Account WHERE Id IN: accountIds]);
        System.debug('mapOfAccountIds ==> ' + mapOfAccountIds);
        for(Contact con :Trigger.new){
            System.debug('con.RecordType.DeveloperName ==> ' + con.RecordType.DeveloperName);
            if(con.RecordTypeId == '0125g000000m31iAAA'){
                Account acc = mapOfAccountIds.get(con.AccountId);
                acc.Contact_Layout_Number__c = acc.Contact_Layout_Number__c + 1;
                accountList.add(acc);
            }else if(con.RecordTypeId == '0125g000000m30uAAA'){
                Account acc = mapOfAccountIds.get(con.AccountId);
                acc.Student_Layout_Number__c = acc.Student_Layout_Number__c + 1;
                accountList.add(acc);
            }
        }
        System.debug('accountList ==> ' + accountList);
        UPDATE accountList;
		*/
    }
    
    
    /*if(Trigger.isInsert && Trigger.isAfter){
for(Contact con : Trigger.new){
Update_Contact_Event_Test__e event1 = new Update_Contact_Event_Test__e();
event1.Name__c = 'Test Event 1';
event1.Description__c = 'Test Description 1';
event1.Pin_Code__c = 30987;
event1.Contact_Record_Id__c = con.Id;
EventBus.publish(event1);
System.debug('event1 ==> ' + event1);    
}
}*/
    
    if((Trigger.isInsert && Trigger.isBefore) || Trigger.isUndelete){
        //ContactTriggerHelper.insertHandle(Trigger.new); 
    }
    if(Trigger.isUpdate && Trigger.isBefore){
        //ContactTriggerHelper.updateHandle(Trigger.newMap, Trigger.oldMap, Trigger.old);
        //ContactTriggerHelper.testError(Trigger.new);
    }
    if((Trigger.isInsert && Trigger.isBefore) || (Trigger.isUpdate && Trigger.isBefore) || (Trigger.isUndelete)) {
        //ContactTriggerHelper.commonMethodForEmailAndLastNameUniqueness(Trigger.newMap, Trigger.oldMap);       
    }
    if(trigger.isInsert || trigger.isUpdate){
        //ContactTriggerHelper.insertAndUpdateCommon(Trigger.new);
    }
    if(Trigger.isInsert && trigger.isAfter){
        //ContactTriggerHelper.checkAccountWithContactDomainName(Trigger.new);
        System.debug('Trigger.new ==>' + Trigger.new);
        System.debug('Trigger.old ==>' + Trigger.old);
        //ContactTriggerHelper.calculateTotalContactOnAccount(Trigger.new);
    }
    
    
}