public class GetAccessTokenUsingRefreshToken {
    
    //Fetched from URL  
    public String accessToken;  
    public String refreshToken;  
    private String code;  
    private string key;  
    private string secret;  
    private string redirect_uri;  
    
    GoogleDrive__c googleCusSetting = new GoogleDrive__c();  

    public void SaveToken()  {  
        code = ApexPages.currentPage().getParameters().get('code') ;  

        //Get the access token once we have code          
        if(code != '' && code != null){
            system.debug('Get the access token once we have code');  
            getToken() ;  
        }  
    }  
	
    //intialization code that redirect to the choose any account.
    public PageReference init(){  
        googleCusSetting = [SELECT Id, Client_Id__c, Client_secret__c, Refresh_Token__c, Access_token__c, GoogleAccountDomain__c, Redirect_Url__c FROM GoogleDrive__c LIMIT 1];  
        System.debug('googleCusSetting ==> ' + googleCusSetting);
        key = googleCusSetting.Client_Id__c;  
        secret = googleCusSetting.Client_secret__c;  
        redirect_uri = googleCusSetting.Redirect_Url__c;  
        code = ApexPages.currentPage().getParameters().get('code'); 
        
        
        
        //Get the access token once we have code  
        PageReference pg;  
        if(code == '' || code == Null){  
            pg = new PageReference(GoogleDriveAuthUri (key , redirect_uri)) ;  
        }  
        System.debug('pg ==> ' + pg);
        return pg ;  
    }  

    //Google drive authorization 
    public String GoogleDriveAuthUri(String Clientkey,String redirect_uri){  
        String key = EncodingUtil.urlEncode(Clientkey,'UTF-8');  
        String uri = EncodingUtil.urlEncode(redirect_uri,'UTF-8');  
        String authuri = '';  
        authuri = 'https://accounts.google.com/o/oauth2/auth?'+  
            'client_id='+key+  
            '&response_type=code'+  
            '&scope=https://www.googleapis.com/auth/drive https://www.googleapis.com/auth/drive.appdata https://www.googleapis.com/auth/drive.file'+  
            '&redirect_uri='+uri+  
            '&state=security_token%3D138r5719ru3e1%26url%3Dhttps://oa2cb.example.com/myHome&'+  
            '&login_hint=jsmith@example.com&'+  
            'access_type=offline'; 
        
        System.debug('authuri ==> ' + authuri);
        return authuri;  
    }  

    public void getToken(){  
        //Getting access token from google  

        HttpRequest req = new HttpRequest();          
        req.setMethod('POST');         
        req.setEndpoint('https://accounts.google.com/o/oauth2/token');  
        req.setHeader('content-type', 'application/x-www-form-urlencoded');  
        
        String messageBody = 'code='+code+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';  
        req.setHeader('Content-length', String.valueOf(messageBody.length()));  
        req.setBody(messageBody);  
        req.setTimeout(60*1000); 
        System.debug('req  ==> ' + req);
        
        Http h = new Http();  
        HttpResponse res = h.send(req);  
        System.debug('res  ==> ' + res);
        
        if(res.getBody() != null && res.getStatusCode()==200){  
            //You can parse the response to get the Access token and Refresh token  
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(res.getBody()); 
            System.debug('results ==> ' + results);
            
            //Access Token   
            if(results.get('access_token') != null){  
                accessToken = string.valueOf(results.get('access_token'));   
                googleCusSetting.Access_token__c = accessToken;  
                System.debug('access token ==> ' + accessToken);
            }  
            
            //Refresh Token    
            if(results.get('refresh_token') != null){  
                refreshToken = string.valueOf(results.get('refresh_token'));  
                googleCusSetting.Refresh_Token__c = refreshToken;   
                System.debug('refresh token ==> ' + refreshToken);
            }  
            System.debug('google Custom Setting  ==> ' + googleCusSetting);
            update googleCusSetting;
            
        }  
		
    } 
    
    public void getDriveFiles(HttpResponse authResponse) {
        http h = new Http();
        Httprequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();      
        
        Map<String, Object> responseObject = (Map<String, Object>) JSON.deserializeUntyped(authResponse.getBody());
        
        req.setEndpoint('https://www.googleapis.com/upload/drive/v2/files');
        req.setMethod('POST');
        req.setHeader('Content-type', 'application/json');
        req.setHeader('Authorization', 'Bearer ' + responseObject.get('access_token'));
        
        String jsonData = '{"title":"NewFolder", "mimeType":"application/vnd.google-apps.folder"}';
        req.setBody(jsonData);
        res = h.send(req);
        
        System.debug('Response Body => '+ res.getBody() +' '+ res.getStatusCode());
        System.debug('Response Status => '+ res.getStatusCode());
        
    }
    
    public void uploadFilesInGoogleDrive(){
        //Create the credentials and Google Drive client
        //Note that 'Sample_Token' needs replacing with the access token provided from the OAuth authenication process.
        /*
        ffhttp_Client.Credentials credentials = new ffhttp_Client.Credentials('Bearer', 'Sample_Token');
        ffhttp_GoogleDrive client = new ffhttp_GoogleDrive(credentials);
        
        //Create a file containing the metadata required.
        ffhttp_GoogleDriveModelFile file = new ffhttp_GoogleDriveModelFile();
        file.setTitle('Test File.txt');
        file.setMimeType('text/plain');
        
        //Create the example file contents
        Blob fileContents = Blob.valueOf('Test document contents');
        
        //Create an insert request to insert the file meta data
        ffhttp_GoogleDriveFiles files = client.files();
        ffhttp_GoogleDriveFiles.InsertRequest insertRequest = files.insertRequest(file, null);
        file  = (ffhttp_GoogleDriveModelFile)insertRequest.execute();
        
        //Create an update request to upload the file data
        ffhttp_GoogleDriveFiles.UpdateRequest updateRequest = files.updateRequest(file, fileContents);
        file  = (ffhttp_GoogleDriveModelFile)updateRequest.execute();
		*/
        
        //This will insert a new file into Google Drive called 'Test File.txt' with the contents 'Test document contents'.
    }
    
    
    //create folder in google drive
    public void createFolderInGoogleDrive(){
        HttpRequest req = new HttpRequest();   
        req.setMethod('POST');  
        req.setEndpoint('https://www.googleapis.com/drive/v3/files');
        System.debug('access token ==> ' + accessToken);  
        req.setHeader('Authorization', 'Bearer' + accessToken);  
    	req.setHeader('content-type', 'application/json');  
        
        String folderName = 'Test';
        String body = '{"name" : "' + folderName + '", "mimeType" : "application/vnd.google-apps.folder"}';
        System.debug('body  ==> ' + body);
        req.setTimeout(60*1000);   
        req.setBody(body);  
		System.debug('req ==> ' + req);
        
        Http http = new Http();  
        HttpResponse res = http.send(req);   
        System.debug('http response result ==> ' + res.getBody());
        
   	}
    
    //create child folder in google drive
    public void createChildFolderInGoogleDrive(){
      	System.debug('===============Creating Child Folder In Parent Folder===================');
        
        HttpRequest req = new HttpRequest();   
        req.setMethod('POST');   
        req.setEndpoint('https://www.googleapis.com/drive/v2/files');             
        req.setHeader('Authorization', 'Bearer ' + accessToken);   
        req.setHeader('content-type', 'application/json');  
        
        String childFolderName = 'testChildFolder';
        String parentFolderId = '1xJWhLyT7qVVGvPOmE2eT6A6pvI3Vvg-5';
        String body = '{"title" : "' + childFolderName + '", "mimeType" : "application/vnd.google-apps.folder", "parents" : [{"kind" : "drive#fileLink", "id" : "' + parentFolderId +'"}]}';     
    
        req.setTimeout(60*1000);   
        req.setBody(body);
        
        Http http = new Http();  
        HttpResponse res = http.send(req);    
        
        System.debug('response body ==> ' + res.getBody());  
        
    }
}