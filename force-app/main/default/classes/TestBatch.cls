public class TestBatch implements Database.Batchable<sObject> {
    
    public Iterable<sObject> start(Database.BatchableContext BC){
        String query;
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        for(sobject s : scope){
            //s.put(Field,Value); 
        }
        update scope;
    }
    
    public void finish(Database.BatchableContext BC){
    }
    
}