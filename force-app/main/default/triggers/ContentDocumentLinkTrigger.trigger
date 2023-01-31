trigger ContentDocumentLinkTrigger on ContentDocumentLink (before insert, after insert) {
    
    ContentDocumentLinkTriggerHandler triggerHandler = new ContentDocumentLinkTriggerHandler();
    
    if(Trigger.isInsert && Trigger.isBefore){
        ContentDocumentLinkTriggerHandler.beforeInsert();
    }
    
    if(Trigger.isInsert && Trigger.isAfter){
        ContentDocumentLinkTriggerHandler.afterInsert();
    }
    
}