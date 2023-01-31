public class showTaskPageController {
    public List<Task> tskList {get;set;}   
    public List<Task> updateList;
    //public List<Integer> serialNumber {get;set;}
    //public Integer sno{get;set;}
    
    public showTaskPageController(ApexPages.StandardController controller){ 
        //serialNumber = new List<Integer>();
        tskList = new List<Task>();
        updateList = new List<Task>();
        for(Task tsk : [SELECT Id, Subject FROM Task WHERE WhoId = NULL]){
            tskList.add(tsk);
            /*if(sno == Null){
                sno = 0;
            }
           	sno++;*/
            //serialNumber.add(sno);	
        }        
    }
    
    public PageReference assignTask(){
        String contactId = ApexPages.currentPage().getParameters().get('id');   //geting id of contact 
        String taskId;
        for(Task tk : tskList){
            taskId = ApexPages.currentPage().getParameters().get(tk.Id);
            if(taskId != Null){
                tk.WhoId = contactId;
                updateList.add(tk);
            }
        }
        upsert updateList;
        PageReference pg = new PageReference('/' + contactId);
   		return pg; 
    }
    
}