public class TimeOutClass {

    static final decimal abc = 11;
  
    @AuraEnabled(cacheable=true)
    public static String timeOutMethod(){
    	System.debug('time out call');
        //abc = 2;
        return 'time out';
        /*
        	LIst<account> accountList;
			for(account acc : accountList){
				acc.Country = 'India';
			}
			Update accountList;

		*/
    }
}