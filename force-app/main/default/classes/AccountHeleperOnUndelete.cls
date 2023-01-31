public class AccountHeleperOnUndelete {

    public static void undeleteHandle(Map<Id, Account> newAccountMap){
        List<Contact> contactList = new List<Contact>();
        if(newAccountMap.size() > 0){
        	contactList = [SELECT Id, Name, Email FROM Contact WHERE AccountId IN: newAccountMap.keySet()];
            if(contactList.size() > 0){
                for(Contact con : contactList){
                    con.Email = 'update.recycle@bin.com';
                }
                System.debug('contact List ==> ' + contactList);
                Update contactList;
            }
        }    
    }
}