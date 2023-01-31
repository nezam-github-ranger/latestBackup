@RestResource(urlMapping='/Account/*')
global with sharing class AccountWebService {
    @HttpGet
    global static Account getRecord() {
        return [SELECT Id,Name,AccountNumber FROM Account];
    }
}