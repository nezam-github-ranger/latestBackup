public class ConversationTopic {
    
    public ConversationTopic(){
    	StaticResource static_resource = [SELECT Id, Name, ContentType, BodyLength, Body, SystemModstamp FROM StaticResource WHERE Name = 'Covnersation_Topic' LIMIT 1];  
     	System.debug('static_resource ==> ' + static_resource); 
        String body = static_resource.Body.toString();
        System.debug('body ==> ' + body);
        //String[] body_line = body.readLine();
        //for(String str : body_line){
            //System.debug('str ==> '+ str);
        //}
    }
}