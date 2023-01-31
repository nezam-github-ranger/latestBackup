public class FieldSetController {
    public List<Contact> contactList {get;set;}
    
    /*String objectName = 'Contact';
    Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
   	set<string> mapset = fieldMap.keyset(); */
    //String allfields = '';  
    //List<String> listOfString {get;set;}
    
    public FieldSetController(){
        contactList = getContact();
        //listOfString = new List<String>();
        /*for(String str : mapset){
            allfields += str + ', ';
            listOfString.add(allfields);
        }*/
        
        /*Map<String, Schema.FieldSet> FsMap = Schema.SObjectType.Contact.fieldSets.getMap();*/
		System.debug('contact List ==> ' + contactList);
    }
    public List<Schema.FieldSetMember> getFields() {
        return SObjectType.Contact.FieldSets.Contacts_Custom_Fieldset.getFields();
    }
    
    public List<Contact> getContact() {
        String query = 'SELECT ';
        Integer i=0;
        Schema.FieldSetMember f;
        for(i=0; i<getFields().size() - 1; i++) {
            f = this.getFields().get(i);
            query +=  f.getFieldPath() + ', '; 
        }
        f = this.getFields().get(i);
        query += f.getFieldPath() +  ' FROM Contact';
        System.debug('query ==> ' + query);
       
        return Database.query(query);
        //return Null;
    }    
}