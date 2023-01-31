trigger HireObjectTrigger on Hire_Form__c (before Insert, after Update) {
    List<Hire_Form__c> hireList = trigger.new;
    List<Contact> contactList = new List<Contact>();
    Contact contactObject = new Contact();
    List<Case> caseList = new List<Case>();
    Case caseObject = new Case();
    
    if(trigger.isInsert){
        System.debug('hire list ' + hireList);
        for(Hire_Form__c hire : hireList){
            hire.Status__c = 'In Progress';
            
            contactObject = new Contact();
            contactObject.FirstName = hire.First_Name__c;
            contactObject.LastName = hire.Name;
            contactObject.Email = hire.Email__c;
            contactObject.Phone = hire.Phone__c;
            
            contactList.add(contactObject);
            System.debug('contactList ==> ' + contactList);
            //hire.Candidate__c = contactList.get(0).Id;
        } 
        Insert contactList;
        for(Integer i=0; i<contactList.size(); i++){
            Contact con = contactList.get(i);
            Hire_Form__c hire = hireList.get(i);
            hire.Candidate__c = con.Id;
            
            caseObject = new Case();
            caseObject.ContactId = con.Id;
            caseObject.Status = 'New';
            caseList.add(caseObject);
        }    
        Insert caseList;
    }
    
    if(trigger.isUpdate){
        System.debug('hire list ==> ' + hireList);
        Set<Id> contactId = new Set<Id>();
        caseList = new List<Case>();
        for(Hire_Form__c hire : hireList){
            if(hire.Status__c == 'Completed'){
                contactId.add(hire.Candidate__c);
            }
        }
        caseList = [SELECT Id, Status FROM Case WHERE ContactId IN: contactId];
        if(caseList.size() > 0){
            for(Case ca : caseList){
                ca.Status = 'Closed';
            }
        }
        Upsert caseList;
    }
}