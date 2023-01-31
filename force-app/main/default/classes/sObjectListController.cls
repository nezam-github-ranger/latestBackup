public class sObjectListController {

    public sObjectListController(){
        List<SObject> sobjectList = [SELECT Id, Name FROM Account LIMIT 10];
        
        System.debug('sobject ==> ' + sobjectList);
        System.debug('sobject size ==> ' + sobjectList.size());
    }
}