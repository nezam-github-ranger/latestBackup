@isTest
public class BulkAccountContactHandler {
    
    public static testMethod void bulkDataConstructorHandle(){
        Test.startTest();
        
        BulkAccountContact bulkObj = new BulkAccountContact();
        System.assert(bulkObj != Null);
        bulkObj.newAccount();
		      
        
        Test.stopTest();
    }
    
    public static testMethod void newContactHandle(){
        Test.startTest();
        
        BulkAccountContact bulkObj = new BulkAccountContact();
        BulkAccountContact.BulkDataStore wrapperObj = new BulkAccountContact.BulkDataStore();
        wrapperObj.accountObj = new Account();
        wrapperObj.contactIndexMap = new Map<Integer, Contact>();
        wrapperObj.serialNo = 0;
        bulkObj.index = 0;
        
        bulkObj.wrapperList.add(wrapperObj);
        bulkObj.newContact();
        
        Test.stopTest();
    }
    
    public static testMethod void removeRowHandle(){
        Test.startTest();
        
        BulkAccountContact bulkObj = new BulkAccountContact();
        BulkAccountContact.BulkDataStore wrapperObj = new BulkAccountContact.BulkDataStore();
        wrapperObj.accountObj = new Account();
        wrapperObj.contactIndexMap = new Map<Integer, Contact>();
        wrapperObj.serialNo = 0;
        bulkObj.index = 0;
        
        bulkObj.wrapperList.add(wrapperObj);
        bulkObj.removeRow();
        
        Test.stopTest();
    }
    
    public static testMethod void contactRemoveRowHandle(){
        Test.startTest();
        
        BulkAccountContact bulkObj = new BulkAccountContact();
        bulkObj.index = 0;
        bulkObj.contactRemovedIndex = 1;
        
        BulkAccountContact.BulkDataStore wrapperObj = new BulkAccountContact.BulkDataStore();
        wrapperObj.accountObj = new Account();
        wrapperObj.contactIndexMap = new Map<Integer, Contact>();
        wrapperObj.serialNo = 0;
        
        bulkObj.wrapperList.get(0).contactIndexMap.put(0, new Contact());
        bulkObj.wrapperList.get(0).contactIndexMap.put(1, new Contact());
        bulkObj.wrapperList.get(0).contactIndexMap.put(2, new Contact());
        bulkObj.contactRemoveRow();
        
        Test.stopTest();
    }
    
    public static testMethod void saveHandle(){
        Test.startTest();
        
        BulkAccountContact bulkObj = new BulkAccountContact();
        bulkObj.index = 0;
        bulkObj.contactRemovedIndex = 1;
        
        BulkAccountContact.BulkDataStore wrapperObj = new BulkAccountContact.BulkDataStore();
        wrapperObj.accountObj = new Account();
        wrapperObj.contactIndexMap = new Map<Integer, Contact>();
        wrapperObj.serialNo = 0;
        
        bulkObj.wrapperList.get(0).accountObj = new Account(Name = 'Test');
        bulkObj.wrapperList.get(0).contactIndexMap.put(0, new Contact(LastName = 'Test'));
        bulkObj.save();
        
        //running else part
        bulkObj.wrapperList.get(0).accountObj = new Account();
        bulkObj.wrapperList.get(0).contactIndexMap.put(0, new Contact());
        bulkObj.save();
        
        bulkObj.wrapperList.get(0).accountObj = new Account(Name = 'Test');
        bulkObj.wrapperList.get(0).contactIndexMap.put(0, new Contact(LastName = Null));
        bulkObj.save();
        
        Test.stopTest();
    }
}