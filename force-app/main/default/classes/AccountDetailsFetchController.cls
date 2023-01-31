/*
	Name 	: AccountDetailsFetchController
	Date 	: 02-04-2021
	Subject : This apex controller is used to find the attachment of particular accounts.

*/
public without sharing class AccountDetailsFetchController {
    
    @AuraEnabled(cacheable = true)
    public static List<AccountDetailsWrapper> getAccounts(String accountId){
        Account accountObject = [SELECT Type, Phone, Website, Industry, Name FROM Account WHERE Id =: accountId];
        List<AccountDetailsWrapper> accountDetailsWrapperList = new List<AccountDetailsWrapper>();
        
        Map<String, String> accountIdAndContentDocumentMap = new Map<String, String>();
        Map<String, String> accountAndContentVersionIdMap = new Map<String,  String>();
      
        List<ContentDocumentLink> contentDocumentLinkList = [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId =: accountId LIMIT 1];
        if(contentDocumentLinkList.size() > 0){
        	accountIdAndContentDocumentMap.put(contentDocumentLinkList.get(0).ContentDocumentId, contentDocumentLinkList.get(0).LinkedEntityId);
            System.debug('accountIdAndContentDocumentMap ==> ' + accountIdAndContentDocumentMap);
            
            ContentVersion cv = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE ContentDocumentId IN: accountIdAndContentDocumentMap.keySet() LIMIT 1];
            accountAndContentVersionIdMap.put(accountIdAndContentDocumentMap.get(cv.ContentDocumentId),cv.Id);
            System.debug('accountAndContentVersionIdMap ==> ' + accountAndContentVersionIdMap);
            
        }
        accountDetailsWrapperList.add(new AccountDetailsWrapper(accountObject,(accountAndContentVersionIdMap.containsKey(accountId) ? accountAndContentVersionIdMap.get(accountId) : Null)));
        
        System.debug('accountDetailsWrapperList ==> ' + accountDetailsWrapperList);
        return accountDetailsWrapperList;
    } 
    
    public class AccountDetailsWrapper{
        @AuraEnabled public Account accountObject;
        @AuraEnabled public String pictures;
       
        public AccountDetailsWrapper(Account accountObject, String pictures){
            this.accountObject = accountObject;
            this.pictures = pictures;
        }
    }
}