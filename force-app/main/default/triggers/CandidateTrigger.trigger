trigger CandidateTrigger on Candidate__c (before update, after update) {
    
    System.debug('Values ==> ' + Trigger.new);
    System.debug('Trigger call on Before ==> ' + Trigger.isBefore);
    System.debug('Trigger call on After ==> ' + Trigger.isAfter);
    
}