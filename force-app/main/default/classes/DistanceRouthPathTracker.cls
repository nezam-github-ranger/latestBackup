@isTest
public class DistanceRouthPathTracker {

    testMethod static void DistnaceRouth_Test1(){
        
        Test.startTest();
        
        Route__c routeObj = new Route__c();
        routeObj.Name = 'NH48';
        Insert routeObj;
        
        Route_Station__c routeStationObj1 = new Route_Station__c();
        routeStationObj1.Name = 'Ajmer';
        routeStationObj1.Distance__c = 43.00;
        routeStationObj1.RouteId__c = routeObj.Id;
        Insert routeStationObj1;
        
        Route_Station__c routeStationObj = new Route_Station__c();
        routeStationObj.Name = 'Jaipur';
        routeStationObj.Distance__c = 23.00;
        routeStationObj.RouteId__c = routeObj.Id;
        routeStationObj.Previous_Station__c = routeStationObj1.Id;
        Insert routeStationObj;
        
        DistanceRouthPath.Wrapper wrapperObj = DistanceRouthPath.fetchRouteStations();
        //Decimal dis = wrapperObj.distance;
        //System.assertEquals(23.00, dis);
        
        Test.stopTest();
        
    }
    
    testMethod static void DistanceRouth_Test2(){
        
    }
    
}