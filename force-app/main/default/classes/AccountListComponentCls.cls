global with sharing class AccountListComponentCls {
    @AuraEnabled
    public static List<Account> getAllAccounts(){  
    	return [SELECT Id, Name, Email__c FROM Account]; 
    } 

    @AuraEnabled
    public static Product__c getProduct(Id recId){  
    	return [SELECT Id, Name, Description__c, Price__c FROM Product__c WHERE Id =: recId]; 
    } 
    
    @AuraEnabled
    public static List<Account> getSearchedAccount(String accName){    
        String searchString = '%' + accName + '%';
        return [SELECT Id, Name, Email__c FROM Account WHERE Name LIKE: searchString LIMIT 5];
    } 
}