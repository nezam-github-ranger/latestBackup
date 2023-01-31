public class AccountHandler {

    public static void insertAccount(Integer numberOfRecords){
        List<Account> addAccounts = new List<Account>();
        for(integer i = 0; i < numberOfRecords; i++){
      		addAccounts.add(new Account(Name =  'Acme Inc' + i, AccountNumber = 'A000' + i));  
        }
        if(addAccounts.size() > 0){
            System.debug('add accounts ==> ' + addAccounts);
            INSERT addAccounts;
        }
    }
}