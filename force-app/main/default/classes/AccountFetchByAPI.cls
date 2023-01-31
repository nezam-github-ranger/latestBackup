@RestResource(urlMapping='/v1/getAccounts/*')
global with sharing class AccountFetchByAPI {
    @HttpGet
    global static list<account> fetchAccount(){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        List<account> listAccount =[Select Id , Name from Account LIMIT 10 ];
        return listAccount ;
    }
}