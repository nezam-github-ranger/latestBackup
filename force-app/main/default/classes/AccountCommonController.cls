public class AccountCommonController {
    public Id accountObjectId {get;set;}
    public Account accountList {
        get{
            return Database.query('SELECT Id, Name, Email__c, Phone, Fax FROM Account WHERE Id =: accountObjectId');
        }    
    	set;
    }
}