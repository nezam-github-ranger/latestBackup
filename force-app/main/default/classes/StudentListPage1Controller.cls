public class StudentListPage1Controller {
    public List<Student__c> studentList {get;set;}
    public List<Student__c> updateList;
    //public String checkIds {get;set;}
    public String selectedId;
    
    public StudentListPage1Controller(){
        studentList = [Select id,First_Name__c,Last_Name__c,Class__c,Date_Of_Birth__c,Email__c,Sex__c FROM Student__c];
        updateList = new List<Student__c>();
        //selectedId = new String();
    }
    
    public PageReference save(){ 
        for(Student__c stList : studentList){
            selectedId = ApexPages.currentPage().getParameters().get(stList.Id);
            System.debug('Selected Id ==> ' + selectedId);
            if(selectedId != Null){
            	//stList.Id = sid;
                updateList.add(stList);
           	}    
        }
        try{
             upsert updateList;
           
        }catch(Exception e){
            Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.FATAL, e.getMessage())); 
        }
         PageReference pg = new PageReference('/apex/StudentListPage');
         pg.setRedirect(true);
         return pg;
    }
    
    /*public void checkedIdFun(){
   		selectedId.add(checkIds);
        System.debug('ids ==> ' + selectedId); 
    }*/
}