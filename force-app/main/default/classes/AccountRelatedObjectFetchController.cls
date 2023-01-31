/*
	Name 	: AccountRelatedObjectFetchController
	Date 	: 02-04-2021
	Subject : This apex controller is used to give all the related object of account values. In this controller have one method that is getRelatedObjectRecord this method have one parameter that is objectName this parameter take a string that is object name and give this object name values from this object fieldset.

*/
public without sharing class AccountRelatedObjectFetchController {
	
    /*------------ This is method name is getRelatedObjectRecord. This method is static and also return fields and object values that are come with parameter*/
    @AuraEnabled(cacheable = true)
    public static List<AccountRelatedObjectWrapper> getRelatedObjectRecord(String objectName, String selectedFieldSet) {
        System.debug('selectedFieldSet ==> ' + selectedFieldSet);
        List<AccountRelatedObjectWrapper> accountRelatedObjectWrapperList = new List<AccountRelatedObjectWrapper>(); 
        List<Columns> columnList = new List<Columns>();
        String query = 'SELECT ';
        List<String> fieldSetLabelAndFieldSetName = new List<String>{'Name', 'Body', 'ContentType'};
        if(objectName.equalsIgnoreCase('Attachment')){
            for(String fieldName : fieldSetLabelAndFieldSetName){
        		columnList.add(new Columns(fieldName, fieldName));
                query += fieldName + ', ';
           	}
        }
        else{
            for(Schema.FieldSetMember fieldSetObject : Schema.getGlobalDescribe().get(objectName).getDescribe().FieldSets.getMap().get(selectedFieldSet).getFields()) {
                    query += fieldSetObject.getFieldPath() + ', ';
                    columnList.add(new Columns(fieldSetObject.label, fieldSetObject.fieldpath));
            }
       }
        
        /*
        if(objectName.equalsIgnoreCase('Contact')){
            for(Schema.FieldSetMember fieldSetObject : SObjectType.Contact.FieldSets.Show_Fields_In_Lwc.getFields()) {
                query += fieldSetObject.getFieldPath() + ', ';
                columnList.add(new Columns(fieldSetObject.label, fieldSetObject.fieldpath));
            }
        }
        else if(objectName.equalsIgnoreCase('Opportunity')){
                for(Schema.FieldSetMember fieldSetObject : SObjectType.Opportunity.FieldSets.Show_Fields_In_Lwc_Opportunity.getFields()) {
                query += fieldSetObject.getFieldPath() + ', ';
                columnList.add(new Columns(fieldSetObject.label, fieldSetObject.fieldpath));
            }
        }
        else if(objectName.equalsIgnoreCase('Task')){
            for(Schema.FieldSetMember fieldSetObject : SObjectType.Task.FieldSets.Show_Fields_In_Lwc_Task.getFields()) {
                query += fieldSetObject.getFieldPath() + ', ';
                columnList.add(new Columns(fieldSetObject.label, fieldSetObject.fieldpath));
            }
        }
		*/
        
        System.debug('column list ==> ' + columnList);
		query += 'Id FROM ' + objectName;
        System.debug('query ==> ' + query);
        accountRelatedObjectWrapperList.add(new AccountRelatedObjectWrapper(Database.query(query), columnList));
        System.debug('accountRelatedObjectWrapperList ==> ' + accountRelatedObjectWrapperList);
        return accountRelatedObjectWrapperList;
    }  
    @AuraEnabled(cacheable = true)
    public static List<Attachment> getAttachmentRecord() {
       	return [SELECT Id, Name, Body, ContentType FROM Attachment];
    }
    
    /*---------------------- This is a wrapper class of AccountRelatedObjectFetchController ------------------------------------ */
    public class AccountRelatedObjectWrapper{
         @AuraEnabled
    	public List<sObject> listOfsObject;
         @AuraEnabled
        public List<Columns> columnList;
        public AccountRelatedObjectWrapper(List<sObject> listOfsObject, List<Columns> columnList){
        	this.listOfsObject = listOfsObject;
            this.columnList=columnList;
        }          
    }  
    
    public class Columns{
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String fieldName;
        public Columns(String label, String fieldName){
        	this.label = label; 
            this.fieldName = fieldName;
        }
    } 
}