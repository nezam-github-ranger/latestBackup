global class ContactLanguageFieldUpdateByBatch implements Database.Batchable<sObject>, Database.Stateful {
	global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, Account.Name, Languages__c FROM Contact]);
    }
    global void execute(Database.BatchableContext bc , List<Contact> contactList){
        for(Contact con : contactList){
            if(con.AccountId != Null){
       			con.Languages__c = con.Account.Name;
            }
        }  
        Upsert contactList;
    }
    global void finish(Database.BatchableContext bc){
    	System.debug('Successfully Updated Contact Language Field......!!!!');  
        //Database.executeBatch(new AccountTypeUpdateByBatch(),10);
    }
}