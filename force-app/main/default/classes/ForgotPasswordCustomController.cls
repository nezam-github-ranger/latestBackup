public with sharing class ForgotPasswordCustomController {

    @auraEnabled
    public static String forgotPassword(String username) {
        System.debug('username ==> ' + username);
  		boolean success = Site.forgotPassword(username);
  		PageReference pr = Page.ForgotPasswordConfirm;
  		pr.setRedirect(true);
  		
  		if (success) {  			
  			return String.valueOf(pr);
  		}
  		return Null;
  	}
    
}