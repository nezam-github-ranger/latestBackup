//Source ORG
public class DataTransfer {
    
    public static final String CONSUMER_KEY = '3MVG9fe4g9fhX0E43z3cV49t5_sFZ.YmUvA._zBrYGVp8nJ.KsTj6sHrSJarI7_rf7JsL4LdZVx.CHC2kAf23';
    public static final String CONSUMER_SECRET = 'B69223060E7B8DE9E277D372180439648D6D2D7ADAF85B21B30B2F19DB7AD949';
    public static final String USER_NAME = 'umar@ibirds.com';
    public static final String PASSWORD = 'laddu@123JIVXEgdMvh2rfDJpFCxrAjEw';
    
    @future(callout=true)
    public static void sendSourceAndDestinationToPartnerOrg(){
        AccessTokenWrapper atw = generateToken();
        //List<String> sourceAndDestination = new List<String>();
        //sourceAndDestination.add('Ajmer');
        //sourceAndDestination.add('Jaipur');
        
        List<Account> sourceAndDestination = [SELECT Id, Name FROM Account];

        if(atw != Null && atw.access_token != Null){
            String requestBody = json.serialize(sourceAndDestination);
            HTTP http = new HTTP();
            HTTPRequest request = new HTTPRequest();
            request.setBody(requestBody);
            request.setMethod('POST');
            
            request.setHeader('Authorization','Bearer ' + atw.access_token);
            request.setHeader('Content-Type','application/json');
            request.setHeader('accept','application/json');
            request.setMethod('GET');
            request.setEndpoint('https://ibirdscollege-c-dev-ed.my.salesforce.com/services/apexrest/v1/getAccounts/');
           
            HTTPResponse response = http.send(request);
            System.debug('respose body ==> ' + response.getBody());
        }
    }
    
    public static AccessTokenWrapper generateToken(){
        String requestBody = 'grant_type=password&client_id='+CONSUMER_KEY+'&client_secret='+CONSUMER_SECRET+'&username='+USER_NAME+'&password='+PASSWORD;
        HTTP http = new HTTP();
        HTTPRequest request = new HTTPRequest();
        request.setBody(requestBody);
        request.setMethod('POST');
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        HTTPResponse response = http.send(request);
        
        System.debug('response.getStatusCode() ==> ' + response.getStatusCode());
        if(response.getStatusCode() == 200){
            return (AccessTokenWrapper) System.JSON.deserialize(response.getBody(), AccessTokenWrapper.class);
        }
        else{
            return Null;
        }
    }
    
    public class AccessTokenWrapper{
        public String access_token;
        public String instance_url;
        public String id;
        public String token_type;
        public String issued_at;
        public String signature;
        
    }
    
}