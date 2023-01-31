public class AccountHelperOnDelete {

    public static void deleteHandle(List<Account> accountList){
   		//Database.emptyRecylebin(accountList);	  
    } 
    public static void AnnualRevenueHandle(List<Account> accountList){
        for(Account acc : accountList){
            if(acc.AnnualRevenue > 50000){
                acc.addError('Annual Revenue is more then 50,000 that\'s why this record is not deleted');
            }
        }	   
    }
}