public class AccountHelperOnUpdate {
	
    public static void afterTriggerExample(Map<Id, Account> oldAccountMap, Map<Id, Account> newAccountMap){
        System.debug('----------- After Trigger Contact Update ---------------');
        System.debug('oldAccountMap ==> ' + oldAccountMap);
        System.debug('newAccountMap ==> ' + newAccountMap);
        Set<Id> accountIds = new Set<Id>();
        for(Account acc : oldAccountMap.values()){
            if(newAccountMap.get(acc.Id).Name != acc.Name && newAccountMap.get(acc.Id).Email__c != acc.Email__c){
				accountIds.add(acc.Id);            	
            }
        }
        List<Contact> contactListToUpdate = new List<Contact>();
        for(Contact con : [SELECT Id, LastName, Email, AccountId FROM Contact WHERE AccountId IN: accountIds]){
            if(newAccountMap.get(con.AccountId).Id == con.AccountId){
            	con.Email = newAccountMap.get(con.AccountId).Email__c;
                contactListToUpdate.add(con);
            }
        }
        System.debug('contactListToUpdate ==> ' + contactListToUpdate);
        UPDATE contactListToUpdate;        
    }
    
    public static void updateOpportunityHandle(Map<Id, Account> accountMap){
        List<Opportunity> opportunityList = [SELECT Id, StageName FROM Opportunity WHERE AccountId IN: accountMap.keySet() AND CreatedDate < Last_Month AND StageName != 'Close Won'];
        for(Opportunity opp : opportunityList){
        	opp.StageName = 'Close Lost';	
        } 
        System.debug('opportunityList ==> ' + opportunityList);
        Update opportunityList;
    }
    
    public static void changeStageHandle(Map<Id, Account> accountMap){
        Set<Id> clientContacts = new Set<Id>();
    	List<Opportunity> opportunityList = [SELECT Id, Name, StageName, Account.Client_Contact__c FROM Opportunity WHERE AccountId IN: accountMap.keySet()];		
        for(Opportunity opp : opportunityList){
            opp.StageName = 'Closed Won';
            clientContacts.add(opp.Account.Client_Contact__c);
        } 
        if(opportunityList.size() > 0){
        	Update opportunityList;    
            List<String> emailList = new List<String>();
            
            for(Contact con : [SELECT Email FROM Contact WHERE Id IN: clientContacts]){
            	emailList.add(con.Email);    
            }
            
            Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
            msg.setSubject('Account Update Info');
            msg.setPlainTextBody('Your account information has been updated successfully.');
            msg.setBccAddresses(emailList);
            
            Messaging.Email[] sendEmail = new Messaging.Email[]{msg};
          	Messaging.sendEmailResult[] result = Messaging.sendEmail(sendEmail);
            
            if(result[0].success){
            	System.debug('Email Send Successfully....!');    
            }
            else{
            	System.debug('Error Msg ==> ' + result[0].errors[0].message);    
            }
        }
    }
    
    public static void manuallyTypeChangePrevent(Map<Id, Account> oldAccountMap, Map<Id, Account> newAccountMap){
        for(Account rec : newAccountMap.values()){
            System.debug('rec => ' + rec.id);
            if(oldAccountMap.get(rec.Id).Type != newAccountMap.get(rec.Id).Type){
            	rec.addError('You can not change the Type manually.');			    
            }	    
        }	    
    }
    
    public static void calculateAssignHours(Map<Id, Account> newAccountMap, Map<Id, Account> oldAccountMap){
        List<Account> accountAssignValuesUpdate = new List<Account>();
        for(Account acc: newAccountMap.values()){
            if(acc.Assign_Date__c != null && oldAccountMap.get(acc.Id).Assign_Date__c == null){
                Datetime startDate = acc.Assign_Date__c;
                Datetime endDate = System.now();
                
                System.debug('startDate ==> ' + startDate);
                System.debug('endDate ==> ' + endDate);
                
                Integer noOfDays = startDate.Date().daysBetween(endDate.Date());
                System.debug('No Of Days : ' + noOfDays);
                
                Datetime sameDayEndDate = startDate.addDays(noOfDays);
                System.debug('Same Day : '+sameDayEndDate);
                
                Decimal hours = ((endDate.getTime())/1000/60/60) - ((sameDayEndDate.getTime())/1000/60/60);
                System.debug('hours : ' + hours); 
                
                acc.Total_Hours_Assign__c = String.valueOf(hours);
                accountAssignValuesUpdate.add(acc);
            }    
        }
        if(accountAssignValuesUpdate.size() > 0){
            //UPDATE accountAssignValuesUpdate;
        }
    }
}