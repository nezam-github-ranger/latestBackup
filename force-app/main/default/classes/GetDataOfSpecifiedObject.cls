@RestResource(urlMapping='/api/getdata/*')
global with sharing class GetDataOfSpecifiedObject {
  
    @readOnly @HttpGet
    global static List<SObject> doGet() { 
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        //String objectName = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        String query = 'SELECT Id FROM Account';// + objectName;
        List<sObject> objList = Database.query(query);
        objList.addAll(objList);
        objList.addAll(objList);
        objList.addAll(objList);
        objList.addAll(objList);
        objList.addAll(objList);
        objList.addAll(objList);
        objList.addAll(objList);
        objList.addAll(objList);
        objList.addAll(objList);
        objList.addAll(objList);
        objList.addAll(objList);
        for(sObject ob: objList){
            if(objList.size() < 1000000){
            	objList.add(ob);    
            }else{
                break;
            }    
        }
        
        System.debug('objList ==> ' + objList);
        System.debug('objList size ==> ' + objList.size()); 
        return objList;
    }

}