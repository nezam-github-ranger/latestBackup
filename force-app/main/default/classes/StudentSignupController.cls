public class StudentSignupController {
    
    public Contact contactSignup {get;set;}
    public Contact contactLogin {get;set;}
    
    public StudentSignupController(){
        contactSignup = new Contact();
        contactLogin = new Contact();
        System.debug('query ==> ' + [SELECT Name, (SELECT Name, Fax FROM Contacts WHERE Fax = '876') FROM Account]);
    }
    
    public PageReference doSave(){
        System.debug('contact signup out ==> ' + contactSignup);
        if(contactSignup != Null){
            System.debug('contact signup ==> ' + contactSignup);
            Account acc = [SELECT Id, Name FROM Account WHERE Name =: 'Starinfotech College'];
            contactSignup.AccountId = acc.Id;
            //INSERT contactSignup;
            contactSignup = new Contact();
            return new PageReference('https://communitydomaindemo-developer-edition.ap24.force.com/ibirds/StudentLogin');
            
        }else{
            return Null;
        }
    }
    
    public PageReference doLogin(){
        if(contactLogin != Null){
            System.debug('contactLogin.Email ==> ' + contactLogin.Email);
            System.debug('contactLogin.Password ==> ' + contactLogin.Password__c);
            Contact con = [SELECT Id, Email, Password__c FROM Contact WHERE Email =: contactLogin.Email AND Password__c =: contactLogin.Password__c];
            
            if(con != Null){
                System.debug('Login Successfully..!!!'); 
                return Null;//Site.login(username,password,null);
            }else{
                return Null;
            }
        }else{
            return Null;
        }   
    }
    
}