public class StudentListPageController {
    public List<Student__c> studentList {get;set;}
    public Student__c stu {get;set;}
    public List<Student__C> deletedRecords;
    
    public String operator {get;set;}   
    public String firstName {get;set;} 
    public Student__c con {get;set;} 
    
    public List<Student__c> updateList;
    
    public StudentListPageController(){
        studentList = [Select id,First_Name__c,Last_Name__c,Class__c,Date_Of_Birth__c,Email__c,Sex__c FROM Student__c];
        con = new Student__c();
        deletedRecords = new List<Student__c>();
        updateList = new List<Student__c>();
    }
    public void addBookingRow(){
        studentList.add(new Student__c());
    }
    public void deleteBookingRow(){
        Student__c stu = new Student__c();
        stu = studentList.get(studentList.size() - 1);
        if(String.isNotBlank(stu.Id)){
            deletedRecords.add(studentList.remove(studentList.size() - 1) );
        }else{
        	studentList.remove(studentList.size() - 1);
        }
    }
    
    public PageReference save(){
        String selectedId;
        for(Integer i=0; i<studentlist.size() ;i++){
            selectedId = ApexPages.currentPage().getParameters().get(String.valueOf(i));
            System.debug('==> ' + selectedId);
            if(selectedId != Null){
            	updateList.add(studentList.get(i));  
            }  
        }
        try{
             upsert updateList;
             delete deletedRecords; 
            
        }catch(Exception e){
            Apexpages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.FATAL, e.getMessage())); 
        }
         PageReference pg = new PageReference('/apex/StudentListPage');
         pg.setRedirect(true);
         return pg;
    }
    public void search(){
        String searchName = '%' + firstName + '%';
        Date dateOfBirth = con.Date_Of_Birth__c;
       	String query = 'SELECT Id, First_Name__c, Last_Name__c, Class__c, Date_Of_Birth__c, Email__c, Sex__c FROM Student__c WHERE ';
       
        if(String.isNotBlank(firstName) && con.Date_Of_Birth__c != Null)
       		 studentList = Database.query(query + 'First_Name__c Like : searchName And Date_Of_Birth__c ' + operator + ': dateOfBirth');
        else       
             studentList = Database.query(query + 'First_Name__c Like : searchName OR Date_Of_Birth__c ' + operator + ': dateOfBirth');
    }
}