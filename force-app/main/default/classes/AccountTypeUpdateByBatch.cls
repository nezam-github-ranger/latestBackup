global class AccountTypeUpdateByBatch implements Database.Batchable<sObject>, Database.Stateful {
	global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, Type FROM Account]);
    }
    global void execute(Database.BatchableContext bc , List<Account> accountList){
        for(Account acc : accountList){
            acc.Type = 'Prospect';
        }  
        Upsert accountList;
    }
    global void finish(Database.BatchableContext bc){
    	System.debug('Successfully Updated AccountType......!!!!');  
        Database.executeBatch(new ContactLanguageFieldUpdateByBatch(),10);
    }
}