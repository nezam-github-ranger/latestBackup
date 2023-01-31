public class Aura_ContactsController {
	@AuraEnabled
    public static List<Contact> getContacts() {
        return [SELECT Id, Name, MailingStreet, Phone, Email, LeadSource FROM Contact];
    }
}