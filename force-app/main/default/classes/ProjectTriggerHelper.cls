/*
    Name	 	:  ProjectTriggerHelper
    Date 		:  06 March, 2021
    Author 		:  Nezam Uddin
    Description :  This is a helper of project trigger. In this helper class i insert 5 record of project task.
*/
public class ProjectTriggerHelper {
    public static void projectTaskInsert(List<Project__c> projectList){
    	List<Project_Task__c> projectTaskList = new List<Project_Task__c>(); 
        
        List<String> taskName = new List<String>();
        taskName.add('New Task');
        taskName.add('Planning Phase');
        taskName.add('Construction Work');
        taskName.add('Completion Step');
        taskName.add('Contract End');
        
        for(Project__c projectObject : projectList){
            for(Integer i = 0; i < 5; i++){
                Project_Task__c projectTaskObject = new Project_Task__c();
                projectTaskObject.Type__c = taskName.get(i);
                projectTaskObject.Project_Name__c = projectObject.Id;
                projectTaskList.add(projectTaskObject);
            }
        } 
        Insert projectTaskList;
        
        Id previousId;
        List<Project_Task__c> projectTaskUpdateList = new List<Project_Task__c>(); 
        for(Project_Task__c projectTaskObject : projectTaskList){
            if(projectTaskObject.Type__c != 'New Task'){
                projectTaskObject.Previous_Task__c = previousId;   
                previousId = projectTaskObject.Id;
            }
            else{
                previousId = projectTaskObject.Id;
            }
            projectTaskUpdateList.add(projectTaskObject);
        }
        
        Update projectTaskUpdateList;
    }    
}