public class SubQueryController {
    public List<Account> accounts {get;set;}
    public SubQueryController(){
        accounts = [SELECT Id, Name, (SELECT Id, Name, Email FROM Contacts) FROM Account];
    }
}