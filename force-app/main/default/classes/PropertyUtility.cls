public class PropertyUtility {

    public static void PropertyUtility(){
        List<Property__c> newPropList = [SELECT Id, Name FROM Property__c];
        System.debug('new prop list ==> ' + newPropList);
    }
    
}