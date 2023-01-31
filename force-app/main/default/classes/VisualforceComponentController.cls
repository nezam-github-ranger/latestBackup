public class VisualforceComponentController {
    public Integer first {get;set;}
    public Integer rows {get;set;}
    public String objectVal {get;set;}
    public List<sObject> sobjectList {
        get{ 
            return Database.query('SELECT Name, Phone FROM ' + objectVal);
        }
        set;
    }
    public void first(){
        rows = 10;
    	first = 1;	    
    }
    public void next(){
        System.debug('sobj ==> ' + sobjectList.size());
        
        if(sobjectList.size() - 10 >= first){
            rows = 10;
    		first = first + rows;   
        }
    }
    public void last(){
    	//first = sobjectList.size() - 10;
    	
        rows =  Math.mod(sobjectList.size(), 10);
        first = sobjectList.size() - 10;
        
    }
    public void previous(){
        rows = 10;
        if(first >= 10){
            first -= 10;
        }		    
    }
    //VisualforceComponentController c = new VisualforceComponentController();
    public VisualforceComponentController(){
        first = 1;
        rows = 10;
        System.debug('object ==> ' + objectVal);
    }
   
}