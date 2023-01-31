public class PracticeClass {

    public static void lockRecord(){
    	List<Account> accountList = [SELECT Id, Name FROM Account WHERE Id =: '0015g00000Ly93pAAB' For Update];
        for(Account acc : accountList){
        	acc.Name = 'Fake Account';    
        }
        Update accountList;
        System.debug('account list ==> ' + accountList);
    }
}