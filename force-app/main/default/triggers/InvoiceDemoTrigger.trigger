trigger InvoiceDemoTrigger on Invoice_Statement__c (before insert, before update) {
    System.debug('hello');
    
    Savepoint sp = Database.setSavepoint();
    
    for(Invoice_Statement__c inv : trigger.new){
        try{
            inv.Id = Null; 
        }
        catch(Exception e){
            Database.rollback(sp);
        }  
    }
    System.debug('t new ==> ' + trigger.new);
}