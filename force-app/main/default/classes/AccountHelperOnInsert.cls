public class AccountHelperOnInsert {

    public static void insertHandle(Map<Id, Account> accountMap){
        /*Map<String, Account> accountEmails = new Map<String, Account>();
        for(Account acc : accountMap.values()){
            if(acc.Email__c != Null){
        		accountEmails.add(acc.Email__c, acc);
            }
        }
        
        List<Account> allAccountList = [SELECT Id, Email__c FROM Account WHERE Email__c IN: accountEmails.keySet()];
        for(Account acc : accountMap.values()){
            for(Account allAccount : allAccountList){
                if(acc.Email__c == allAccount.Email__c){
                	acc.addError('This email is already exist!');    
                }
            }    
        }
        */
        
        
        List<Contact> contactList = new List<Contact>();
        for(Account acc : accountMap.values()){
            contactList.add(new Contact(LastName = acc.Name + ' Contact', AccountId = acc.Id));
        }
        if(contactList.size() > 0){
            insert contactList;
        }
        //Username, Email, Alias, TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, ProfileId, LanguageLocaleKey]: [Username, Email, Alias, TimeZoneSidKey, LocaleSidKey, EmailEncodingKey, ProfileId, LanguageLocaleKey
        List<User> userList = new List<User>();
        for(Contact con : contactList){
        	User userObj = new User();
            userObj.LastName = con.Account.Name;
            userObj.Email = con.Email;
            userObj.Alias = con.Email;
        }
        List<Account> accList = [SELECT Id, Client_Contact__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN: accountMap.keySet()];
        System.debug('accList ==> ' + accList);
        
        for(Account acc : accList){
            for(Contact con : acc.Contacts){
                acc.Client_Contact__c = con.Id;
            }
        }
        
        if(accList.size() > 0){
            System.debug('Account List ==> ' + accList);
            Update accList;
        }
        
        /*for(Account acc : accountMap){
            for(Contact con : contactList){
                acc.Client_Contact__c = con.Id;
            }
        }
        if(accountMap.size() > 0){
            Update accountMap;
        }
		*/
    }
}