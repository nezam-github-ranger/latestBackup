global class SpacificObjectDataReturnAPI {
	    
    public static Map<String, Object> objectDataReturn(String objectName){
        System.debug('Api Call objectName ==> ' + objectName);  
        String cityName = objectName.substringAfter('|');
        System.debug('cityName ==> ' + cityName);
        String apiKey = '7fa3d40797d21ffd26c555069151cfc0';
        String requestEndPoint = 'http://api.openweathermap.org/data/2.5/weather';
        requestEndPoint += '?q=' + objectName + '&units=metric' + '&APPID=' + apiKey;
        
        Http http = new Http(); 
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestEndPoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        String query = 'SELECT Id, Name FROM ' + objectName.substringBefore('|') + ' LIMIT 200';
        System.debug('query ==> ' + query);
        List<sObject> sObjectList = Database.query(query);
        System.debug('sObjectList ==> ' + sObjectList);
        
        Map<String, List<Object>> resultMap = new Map<String, List<Object>>();
        if(response.getStatusCode() == 200){
       		resultMap.put(objectName.substringBefore('|'), sObjectList);   
        }
        //Map<String, List<Object>> resultMap =  response.getStatusCode() == 200 ? (Map<String, Object>)((Map<String, Object>)JSON.deserializeUntyped(response.getBody())).get('main') : new Map<String, String>();
        
        System.debug('resultMap ==> ' + resultMap);
        return resultMap;
    }
}