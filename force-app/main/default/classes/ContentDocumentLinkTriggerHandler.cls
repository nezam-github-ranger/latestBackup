public class ContentDocumentLinkTriggerHandler {//extends TriggerHandler {
    
    public ContentDocumentLinkTriggerHandler() {}
    public static List<ContentDocumentLink> newList { get { return (List<ContentDocumentLink>) Trigger.new; } }
    
    public static void beforeInsert() {
        ContentDocumentLinkTriggerHandler.shareDocumentToAllUser(trigger.new);
    }
    
    public static void afterInsert() {
        ContentDocumentLinkTriggerHandler.shareDocument(trigger.new);
    }
  
    public static void shareDocumentToAllUser(List<ContentDocumentLink> listOfContentDocumentLink){
        for(ContentDocumentLink conDocObj: listOfContentDocumentLink){
            conDocObj.Visibility  = 'AllUsers';
        }
    }
   
    public static void shareDocument(List<ContentDocumentLink> listOfContentDocumentLink){
        List<id> cdlid=New List<Id>();    
        for(ContentDocumentLink cdl1: listOfContentDocumentLink){
            String idd=cdl1.linkedentityid;
            if(idd.startsWith('500')){
                cdlid.add(cdl1.contentdocumentid);
            }
        }
        List<ContentVersion> cvl=[select id from Contentversion where id in :cdlid];
    }    
    
}