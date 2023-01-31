public class InlineNewContactController {
    public Contact contact {get;set;}
    Id accId ;
    public InlineNewContactController(ApexPages.StandardController sc){
        accId = sc.getId();
        System.debug('Whole Record ==> ' + sc.getRecord());
        System.debug('accid ==> ' + accId);
        contact = new Contact(AccountId = accId, LastName = 'Contact Last Name');
        System.debug('con ==> ' + contact);
    }
    
    public PageReference save(){
        insert contact;
        System.debug('con ==> ' + contact);
        return null;
    }
}