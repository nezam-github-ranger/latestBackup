public class UploadingFileInGoogleDrive {
    private String code;
    public boolean val {
        get;
        set;
    }
    
    public blob file {
        get;
        set;
    }
    
    public String filetype {
        get;
        set;
    }
    
    public String filename {
        get;
        set;
    }
    
    public Id ContactId = ApexPages.currentPage().getParameters().get('Id');
    private string key = '790281702280-nfodr5s4q01kvelr241q1da189aru1k1.apps.googleusercontent.com';
    private string secret = 'MIQ83hwENu7L_y-N5_x7Lsps';
    private string redirect_uri = 'https://ibirds-4f-dev-ed.my.salesforce.com/_ui/common/apex/debug/ApexCSIPage'; 
    // Should be //the same URL in authorized URL in your Google Developers Console //Project.
    private String accesstoken;
    private String refreshtoken;
    private String thumbnailLink;
    private String fid;
    private String clink;
    private Integer expiresIn;
    private String tokentype;
    Google_Drive_Token__mdt  gd = [SELECT Refresh_Token__c FROM Google_Drive_Token__mdt WHERE DeveloperName = 'Google_Drive_Token__mdt'];
    
    
    public void GoogleDriveController() {
        
    }
    
    public PageReference UploadFile() {
        refreshtoken = gd.Refresh_Token__c;
        
        try{
            //Getting access token from google
            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setEndpoint('https://www.googleapis.com/oauth2/v4/token');
            req.setHeader('content-type', 'application/x-www-form-urlencoded');
            String messageBody = 'client_id=' + key + '&client_secret=' + secret + '&refresh_token='+refreshtoken+'&redirect_uri=' + redirect_uri + '&grant_type=refresh_token';
            req.setHeader('Content-length', String.valueOf(messageBody.length()));
            req.setBody(messageBody);
            req.setTimeout(60 * 1000);
            Http h = new Http();
            String resp;
            HttpResponse res = h.send(req);
            resp = res.getBody();
            
            JSONParser parser = JSON.createParser(resp);
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)) {
                    String fieldName = parser.getText();
                    parser.nextToken();
                    if (fieldName == 'access_token') {
                        accesstoken = parser.getText();
                    } else if (fieldName == 'expires_in') {
                        expiresIn = parser.getIntegerValue();
                    } else if (fieldname == 'token_type') {
                        tokentype = parser.getText();
                    }
                    
                } }
        } catch
            (Exception e) {
                System.debug(LoggingLevel.ERROR,
                             'Call exception ' + e.getMessage());
            } 
        
        
        System.debug(ContactId);
        String boundary = '----------9889464542212';
        String delimiter = '\r\n--' + boundary + '\r\n';
        String close_delim = '\r\n--' + boundary + '--';
        if(file!=null)
        {
            String bodyEncoded = EncodingUtil.base64Encode(file);
            //Folder Id of Google drive Folder
            String FolderId='1ob-7bEuyUZRxf47wgMJ_Kv2o4UrATRgt';
            String body = delimiter + 'Content-Type: application/json\r\n\r\n' + '{ "title" : "' + filename + '",' + ' "mimeType" : "' + filetype + '",' + '"parents":[{"id":"'+ FolderId +'"}]}' + delimiter + 'Content-Type: ' + filetype + '\r\n' + 'Content-Transfer-Encoding: base64\r\n' + '\r\n' + bodyEncoded + close_delim;
            try{
                Http http = new Http();
                HttpRequest req1 = new HttpRequest();
                req1.setEndpoint('https://www.googleapis.com/upload/drive/v2/files?uploadType=multipart&withLink=true');
                req1.setHeader('Authorization', 'Bearer ' + accesstoken);
                req1.setHeader('Content-Type', 'multipart/mixed; boundary="' + boundary + '"');
                req1.setHeader('Content-length', String.valueOf(body.length()));
                req1.setBody(body);
                req1.setMethod('POST');
                req1.setTimeout(60 * 1000);
                HttpResponse resp1 = http.send(req1);
                System.debug(resp1.getBody());
                
                Map<String, Object> p = (Map<String, Object>) JSON.deserializeUntyped(resp1.getBody());
                thumbnailLink= (String) p.get('thumbnailLink');
                fid=(String) p.get('id');
                System.debug(fid);
                clink='https://drive.google.com/uc?export=view&id='+fid;
                
                //Changing file permission to public viewable using link
            } catch
                (Exception e) {
                    System.debug(LoggingLevel.ERROR,
                                 'Call exception ' + e.getMessage());
                }  
            String body1 = '{"role":"reader","type":"anyone"}';
            try{
                Http http = new Http();
                HttpRequest req1 = new HttpRequest();
                req1 = new HttpRequest();
                req1.setEndpoint('https://www.googleapis.com/drive/v2/files/'+fid+'/permissions');
                req1.setHeader('Authorization', 'Bearer ' + accesstoken);
                req1.setHeader('Content-Type', 'application/json');
                req1.setHeader('Content-length', String.valueOf(body1.length()));
                req1.setBody(body1);
                req1.setMethod('POST');
                req1.setTimeout(60 * 1000);
                HttpResponse resp1 = http.send(req1);
                System.debug(resp1.getBody());
            } catch
                (Exception e) {
                    System.debug(LoggingLevel.ERROR,
                                 'Call exception ' + e.getMessage());
                }  
            if(ContactId != Null) {
                Contact c = [SELECT Id, Image_URL__c FROM Contact WHERE Id =: ContactId];
               	c.Image_URL__c =clink;
                update c;                    
            }
        }
        PageReference returnPage = new PageReference('/lightning/r/Contact/'+ContactId+'/view?0.source=alohaHeader');  
        
        return returnPage;
    }   
}