@RestResource(urlMapping='/showAccountDetails/*')
global class CheckAccounts {
   
    /*@HttpGet
    global static List<Account> getAccount(){
        //List<Account> accountList = new List<Account>();
        try{
        	return [SELECT Id, Name, Phone FROM Account LIMIT 10];    
        }
        catch(Exception ex){
        	System.debug('Exception ==> ' + ex.getMessage());    
        }
        return Null;
    }*/
    
    @HttpGet
    global static Account doGet(){
   		
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        System.debug('Account Id ==> ' + accountId);
        Account accountResult = [SELECT Id, Name, Phone, Website FROM Account WHERE Id =: accountId];
        return accountResult;
    }
    
    @HttpPost
    global static String doPost(String name, String phone, String website){
        Account accountObj = new Account();
        accountObj.Name = name;
        accountObj.Phone = phone;
        accountObj.Website = website;
        
        Insert accountObj;
        return accountObj.Id;
    }
    
    @HttpDelete
    global static String doDelete(){
    	RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Account accountObj = [SELECT Id, Name, IsDeleted FROM Account WHERE Id =: accountId];
        System.debug('accountobj == >' + accountObj);
        delete accountObj;
        System.debug('accountobj == >' + accountObj);
        if(accountObj == Null){
            return 'Successfully Account Deleted!';
        }else{
            return 'Account Not Deleted!';
        }
    }
}