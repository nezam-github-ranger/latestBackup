@isTest
public class InlineNewContactTest {
    @isTest static void inlineConstructorCall(){
        Account acc = new Account(Name = 'Test');
        Insert acc;
        System.debug('ac ==> ' + acc);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        System.debug('before icc ==> ' + sc.getId());
        InlineNewContactController icc = new InlineNewContactController(sc);
        System.debug('icc ==> ' + sc.getId());
        //Contact con = new Contact(AccountId = acc.Id, LastName = 'Last Name Test');
        
        icc.save();
        //PageReference pg = icc.save();
    }
    /*@isTest static void saveCall(){
        Account acc = new Account(Name = 'Test');
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        InlineNewContactController icc = new InlineNewContactController(sc);
        Contact con = new Contact(AccountId = acc.Id);
        
            
    }*/
}