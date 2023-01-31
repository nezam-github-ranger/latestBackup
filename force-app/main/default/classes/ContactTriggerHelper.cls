public class ContactTriggerHelper {
    
    public static void updateHandle(Map<Id, Contact> contactNewMap, Map<Id, Contact> contactOldMap, List<Contact> oldTriggerList){
        System.debug('new map ==> ' + contactNewMap);
        System.debug('old map ==> ' + contactOldMap);
        List<String> contactEmails = new List<String>();
        for(Contact con : contactNewMap.values()){
            if(con.Email != Null){
                contactEmails.add(con.Email);    
            }
        }
        
        Map<Id, Contact> existRecord = new Map<Id, Contact>([SELECT Id, Email, LastName FROM Contact WHERE Email IN : contactEmails]);
        for(Contact con : contactNewMap.values()){
            if(con.Email != contactOldMap.get(con.Id).Email || con.LastName != contactOldMap.get(con.Id).LastName){
                System.debug('in if');
                for(Contact con1 : existRecord.values()){
                    //if(existRecord.get(con.Id).Email == con.Email || existRecord.get(con.Id).LastName == con.LastName){
                    System.debug('con.Email ==> ' + con.Email);
                    System.debug('con1.Email ==> ' + con1.Email);
                    if(con.Email == con1.Email || con.LastName == con1.LastName){
                        System.debug('match');
                        con.addError('Email or LastName is duplicate!!!');   
                        System.debug('existRecord  ==> ' + existRecord);
                    }    
                }
            }    
        }
        
        Set<Id> oldContactIds = new Set<Id>();
        for(Contact con : oldTriggerList){
            if(String.isNotBlank(con.AccountId)){
                oldContactIds.add(con.AccountId);
            }    
        }
        if(oldContactIds.size() > 0){
            List<Contact> conList = [SELECT id, Name, CreatedDate, Email, AccountId FROM Contact WHERE AccountId IN: oldContactIds];
            List<Account> accList = [SELECT Id, Primary_Contact_Email__c FROM Account WHERE Id IN: oldContactIds];
            Map<Id, List<Contact>> conMap = new Map<Id, List<Contact>>();
            for(Contact con : conList){
                if(!conMap.containsKey(con.AccountId)) {
                    conMap.put(con.AccountId, new List<Contact>());
                }   
                conMap.get(con.AccountId).add(con);
            }
            System.debug('con list ==> ' + conList.size());
            if(conList.size() > 0){
                for(Account ac : accList){
                    Boolean isAvailable = true;
                    List<Contact> cList = conMap.get(ac.Id);
                    for(Contact c : cList){
                        if(String.isNotBlank(c.Email) && String.isBlank(ac.Primary_Contact_Email__c)){
                            ac.Primary_Contact_Email__c = c.Email;
                            System.debug('is here ==> ' + c.Email);  
                        }
                    }
                }
            }else{ 
                for(Account ac : accList){
                    ac.Primary_Contact_Email__c = '';
                    System.debug('ac list ==> ' + accList);
                }
            }
            System.debug('acc List ==> ' + accList);
            Upsert accList;
        } 
        Map<Id, Contact> oldContactMap = contactOldMap;
        Set<Id> accIds = new Set<Id>();
        if(trigger.isUpdate){
            for(Contact con : oldTriggerList){
                accIds.add(con.AccountId);
            }
            for(Contact con : contactNewMap.values()){
                accIds.add(con.AccountId);
            }
            
            Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Name, Total_Contact__c FROM Account WHERE Id IN: accIds]);
            for(Contact newCon : contactNewMap.values()){
                Contact oldCon = oldContactMap.get(newCon.Id);
                if(oldCon.AccountId != newCon.AccountId && oldCon.AccountId != Null){
                    accountMap.get(oldCon.AccountId).Total_Contact__c-- ;
                    System.debug('whyyyyyyyyyyy' + oldCon.AccountId);
                }
                //else if(oldCon.AccountId == Null && newCon.AccountId != Null){
                //accountMap.get(newCon.AccountId).Total_Contact__c = 1;
                //}
            }
            Upsert accountMap.values();
        }
            /*
            Map<Id, List<Contact>> acctContactMap = new Map<Id, List<Contact>>();
            Set<Id> acctIds = new Set<Id>();   
            List<Account> acctList = new List<Account>();
            List<Contact> conList = new List<Contact>();
            Map<Id, Contact> oldContactMap = contactOldMap;
            Set<Id> accIds = new Set<Id>();
            
            if(trigger.isUpdate){
                for(Contact con : trigger.old){
                    accIds.add(con.AccountId);
                }
                for(Contact con : trigger.new){
                    accIds.add(con.AccountId);
                }
                
                Map<Id, Account> accountMap = new Map<Id, Account>([SELECT Id, Name, Total_Contact__c FROM Account WHERE Id IN: accIds]);
                for(Contact newCon : trigger.new){
                    Contact oldCon = oldContactMap.get(newCon.Id);
                    if(oldCon.AccountId != newCon.AccountId && oldCon.AccountId != Null){
                        accountMap.get(oldCon.AccountId).Total_Contact__c-- ;
                        System.debug('whyyyyyyyyyyy' + oldCon.AccountId);
                    }
                    //else if(oldCon.AccountId == Null && newCon.AccountId != Null){
                    //accountMap.get(newCon.AccountId).Total_Contact__c = 1;
                    //}
                }
                Upsert accountMap.values();
            }
            
            if(trigger.isInsert || trigger.isUpdate) {
                for(Contact con : trigger.New) {
                    if(String.isNotBlank(con.AccountId)){
                        acctIds.add(con.AccountId); 
                    }
                }
                system.debug('acctIds :: ' +acctIds);
                if(acctIds.size() > 0){
                    conList = [SELECT Id, AccountId FROM Contact WHERE AccountId IN : acctIds];
                    System.debug('conList :: ' +conList);
                    for(Contact con : conList) {
                        if(!acctContactMap.containsKey(con.AccountId)){
                            acctContactMap.put(con.AccountId, new List<Contact>());
                        }else{
                            acctContactMap.get(con.AccountId).add(con);
                        }
                        System.debug('acc Map ==> ' + acctContactMap);
                    } 
            }
            
            for(Account acc : [SELECT Total_Contact__c FROM Account WHERE Id IN : acctIds]) {
                System.debug('acctContactMap ==> ' + acctContactMap.get(acc.Id));
                List<Contact> contList = acctContactMap.get(acc.Id);
                
                System.debug('contList ==> ' + contList);
                System.debug('contList.size() ==> ' + contList.size());
                if(contList.size() > 0){
                    acc.Total_Contact__c = contList.size() + 1;  
                }else{
                    acc.Total_Contact__c = 1;
                }  
                acctList.add(acc);
                System.debug(acc);
            }   
            update acctList;
        }
        */
        
    }
    
    public static void insertHandle(List<Contact> newContactList){
        System.debug('newContactList ==> ' + newContactList);
        List<Contact> existRecord = [SELECT Id, Email, LastName FROM Contact WHERE Email != Null];  
        System.debug('existRecord ==> ' + existRecord);
        for(Contact conExist : existRecord){
            for(Contact conNew : newContactList){
                if(conNew.Email == conExist.Email || conNew.LastName == conExist.LastName){
                    conNew.addError('Email or LastName is duplicate!!!'); 		    
                }    
            }	
        }
    }
    
    public static void commonMethodForEmailAndLastNameUniqueness(Map<Id, Contact> contactNewMap, Map<Id, Contact> contactOldMap){
        if(contactOldMap.size() > 0 || contactOldMap == Null){
            List<Contact> existRecord = [SELECT Id, Email, LastName FROM Contact];  
            System.debug('existRecord ==> ' + existRecord);
            for(Contact conExist : existRecord){
                for(Contact conNew : contactNewMap.Values()){
                    if(conNew.Email == conExist.Email || conNew.LastName == conExist.LastName){
                        conNew.addError('Email or LastName is duplicate!!!'); 		    
                    }    
                }	
            }    
        }
        if((contactOldMap.size() > 0 || contactOldMap == Null) && (contactNewMap.size() > 0 || contactNewMap == Null)){
            Map<Id, Contact> existRecord = new Map<Id, Contact>([SELECT Id, Email, LastName FROM Contact]);
            for(Contact con : contactNewMap.values()){
                if(con.Email != contactOldMap.get(con.Id).Email || con.LastName != contactOldMap.get(con.Id).LastName){
                    System.debug('in if');
                    if(existRecord.get(con.Id).Email == con.Email || existRecord.get(con.Id).LastName == con.LastName){
                        con.addError('Email or LastName is duplicate!!!');    
                    }
                }    
            }    
        }
    }
    
    public static void insertAndUpdateCommon(List<Contact> newContactList){
        
        Set<Id> accountIds = new Set<Id>();
        Map<Id, List<Contact>> contactMap = new Map<Id, List<Contact>>();
        List<Account> accountList = new List<Account>();
        List<Contact> contactList;
        
        for(Contact con : newContactList){
            if(String.isNotBlank(con.AccountId)){
                accountIds.add(con.AccountId);    
            }
        }   
        if(accountIds.size() > 0){
            for(Contact con : [SELECT id, Name, CreatedDate, Email, AccountId FROM Contact WHERE AccountId IN: accountIds]){
                contactList = new List<Contact>();
                contactList.add(con);
                if(!contactMap.containsKey(con.AccountId)){
                    contactMap.put(con.AccountId, new List<Contact>());    
                }
                contactMap.get(con.AccountId).add(con);
                System.debug('s contact ==> ' + con);
            }
            System.debug('con Map ==> ' + contactMap);
            
            for(Account acc : [SELECT Id, Primary_Contact_Email__c FROM Account WHERE Id IN: accountIds]){
                Boolean isEmailAvailable = true;
                List<Contact> conList = contactMap.get(acc.Id);
                for(Contact con : conList){
                    if(String.isNotBlank(con.Email) && String.isBlank(acc.Primary_Contact_Email__c)){
                        acc.Primary_Contact_Email__c = con.Email;
                        isEmailAvailable = false;
                        //break;
                        System.debug('con.email ==> ' + con.Email + 'acc.primary ==> ' + acc.Primary_Contact_Email__c);
                    } 
                }  
                if(isEmailAvailable){
                    acc.Primary_Contact_Email__c = '';   
                }
                accountList.add(acc);
            }
            System.debug('acount List ==> ' + accountList);
            Upsert accountList;
        }
    }
    
    public static void checkAccountWithContactDomainName(List<Contact> contactList){
        System.debug('contact List ==> ' + contactList);
    	Map<String, Contact> emailDomainNameMap = new Map<String, Contact>();
        List<Account> accountList = new List<Account>();
        for(Contact con : contactList){
            if(String.isNotBlank(con.Email)){
            	emailDomainNameMap.put(con.Email.substringAfter('@'), con);  
            }
        }
        if(emailDomainNameMap.size() > 0 && emailDomainNameMap != Null){
            for(Contact con : emailDomainNameMap.values()){
                if(con.AccountId == Null){
                	accountList.add(new Account(Name = con.Email.subStringAfter('@'), Date_And_Time__c = Date.today())); 	    
                }
            }
            if(accountList.size() > 0 && accountList != Null){
                INSERT accountList;
            }
            for(Account acc : [SELECT Id, Name FROM Account WHERE Name IN : emailDomainNameMap.keySet()]){
                if(emailDomainNameMap.containsKey(acc.Name)) {
                    emailDomainNameMap.get(acc.Name).AccountId = acc.Id;			    
                }
            }
        }
        System.debug('emailDomainNameMap.values() ==> ' + emailDomainNameMap.values());
    }
    
    public static void calculateTotalContactOnAccount(List<Contact> contactList){
        System.debug('Contact List => ' + contactList);
    	Set<Id> accountIds = new Set<Id>();
        for(Contact con : contactList){
            if(con.AccountId != Null){
            	accountIds.add(con.AccountId);		      
            }    
        }
        List<Account> allRelatedAccounts = [SELECT Id, Name, (SELECT Id, Name, AccountId  FROM Contacts WHERE AccountId IN : accountIds) FROM Account WHERE Id IN : accountIds];
        System.debug('allRelatedAccounts ==>  ' + allRelatedAccounts);
        for(Account acc : allRelatedAccounts){
            System.debug('acc.Contacts.size() ==> ' + acc.Contacts.size());
            acc.Total_Contact__c = acc.Contacts.size();     
        }
        if(allRelatedAccounts.size() > 0 && allRelatedAccounts != Null){
            System.debug('allRelatedAccounts ==> ' + allRelatedAccounts);
            UPDATE allRelatedAccounts;
        }
    }
    
    public static void testError(List<Contact> contactList){
        Map<String,Contact> contactEmails = new Map<String,Contact>();
        for(Contact con : contactList){
        	contactEmails.put(con.Email,con);
        }    
        List<Contact> availableEmailRec = [SELECT Email FROM Contact WHERE Email IN : contactEmails.keySet()];
        if(availableEmailRec.size() > 0 && availableEmailRec != Null){
            for(Contact con : availableEmailRec ){
                if(contactEmails.containsKey(con.Email)){
                	//contactEmails.get(con.Email).addError('invalid email');
                }
            }				    
        }
        if(contactEmails.size() > 0){
            List<Database.SaveResult> lst = Database.update(contactEmails.values(), false);
            for(Database.SaveResult rst : lst){
                System.debug('rst : '+rst.getErrors());
            }
        }
    }
}