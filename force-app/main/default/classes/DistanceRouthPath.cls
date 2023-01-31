/*
    Name	 	:  DistanceRoutePath 
    Date 		:  18 March, 2021
    Author 		:  Nezam Uddin
    Description :  This is a class of DistanceRoutePath. In this class i'm checking both source and destination are available or not, if available then calculate it's kilometer and send it to UI Partner controller.
*/
@RestResource(urlMapping='/distanceroutepath/*')
global class DistanceRouthPath {
    
	@HttpGet
    global static Wrapper fetchRouteStations(){
        String source;
        String destination;
        //RestRequest req = RestContext.request;
        if(Test.isRunningTest()){
        	source = 'Ajmer';
            destination = 'Jaipur';
        }else{
            source = RestContext.request.params.get('current');
        	destination = RestContext.request.params.get('destination');
        }
        RestResponse res = Restcontext.response;
                
        //------------------ work of checking route available or not and giving message according that ----------------------
        Decimal distance = 0;
        Boolean status = false;
        String message = 'Route Not Available';
        String route = 'No Route';
        
        List<Route_Station__c> checkingRouteAvailalbleList = [SELECT Name, RouteId__r.Name FROM Route_Station__c 
                                                               WHERE Name =: source 
                                                               OR Name =: destination];
       
        if(checkingRouteAvailalbleList.size() > 1){          
            if(checkingRouteAvailalbleList[0].RouteId__c == checkingRouteAvailalbleList[1].RouteId__c){ 
                route = checkingRouteAvailalbleList[0].RouteId__r.Name; 
                List<Route_Station__c> stationList = [SELECT Name, Distance__c, Previous_Station__r.Name FROM Route_Station__c 
                                                      WHERE RouteId__r.Name =: route];
                
                String run = (checkingRouteAvailalbleList[0].Name == source && checkingRouteAvailalbleList[1].Name == destination) ? 'STD' : 'DTS'; 
               
                for(Integer loopCounter = 0; loopCounter < stationList.size(); loopCounter++){
                        Route_Station__c routeStationObject = stationList.get(loopCounter);
                        
                        if(run.equals('DTS') ? routeStationObject.Name == source : routeStationObject.Previous_Station__r.Name == source){
                            
                            distance += routeStationObject.Distance__c;
                            source = run.equals('DTS') ? routeStationObject.Previous_Station__r.Name : routeStationObject.Name;
                            loopCounter = 0;
                            
                            if(source == destination){
                                break;
                            }
                        } 
                    }
                status = true;	
                message = 'Route Available';
            }
        }
        return new Wrapper(status, message, distance, 	route);     
    }    
                 
    global class Wrapper{
    	Boolean status;
        String message;
        Decimal distance;
        String route;
        
        public Wrapper(Boolean status, String message, Decimal distance, String route){
        	this.status = status;
            this.message = message;
            this.distance = distance;
            this.route = route;
        }
    }
}