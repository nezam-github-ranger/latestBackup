/*
    Name	 	:  TheaterShowsDetails 
	Project     :  Book My Show
    Date 		:  29 April, 2021
    Author 		:  Nezam Uddin
    Description :  This class is used to fetch all the booking and their category and the seats of all the category.
*/
public class TheaterShowsDetails {

    @AuraEnabled(cacheable = true)	
    public static List<MovieSeatModel> fetchSeatCategoryDetails(){
        System.debug('userId  ==> ' + userInfo.getUserId());
        String userId = userInfo.getUserId();
        
        Map<Id, Seat_Booking__c> seatBookingMap = new Map<Id, Seat_Booking__c>([SELECT Total_Amount__c, Movie__c, Movie__r.Name, Status__c, OwnerId FROM Seat_Booking__c WHERE OwnerId =: userId]);
        Map<Id, Map<String, List<String>>> seatsAndCategoryMap = new Map<Id, Map<String, List<String>>>();
      
        for(Booking_Line_Item__c lineItemObject : [SELECT Seat__r.Name, Seat_Category__r.Name, Booking__c FROM Booking_Line_Item__c WHERE Booking__c IN: seatBookingMap.keySet()]){
            Map<String, List<String>> tempMap = seatsAndCategoryMap.get(lineItemObject.Booking__c);
            
            if(tempMap == Null){
            	tempMap = new Map<String, List<String>>();    
            }
            
            List<String> tempList = tempMap.get(lineItemObject.Seat_Category__r.Name);
            if(tempList == Null){
                tempList = new List<String>();
            }
            tempList.add(lineItemObject.Seat__r.Name);
            tempMap.put(lineItemObject.Seat_Category__r.Name, tempList);
            seatsAndCategoryMap.put(lineItemObject.Booking__c,tempMap);
        }
      
        List<MovieSeatModel> modelList = new List<MovieSeatModel>();
        for(Seat_Booking__c seatData : seatBookingMap.values()){
            
            Map<String, List<String>> lineItemMap  = new Map<String, List<String>>();
            lineItemMap = seatsAndCategoryMap.get(seatData.Id);
            modelList.add(new MovieSeatModel(seatData.Id, seatData.Status__c, seatData.Movie__r.Name, new List<String>(lineItemMap.keySet()), lineItemMap.values(), seatData.Total_Amount__c));
            System.debug('modelList ==> ' + modelList);
        }
    	return modelList;
    }
    public class MovieSeatModel{
        @AuraEnabled public String seatBookingId;
        @AuraEnabled public String status;
    	@AuraEnabled public String movie;
        @AuraEnabled public List<String> category;
        @AuraEnabled public List<List<String>> seats;
        @AuraEnabled public Decimal amount;
        
        public MovieSeatModel(String seatBookingId, String status, String movie, List<String> category, List<List<String>> seats, Decimal amount){ 
           	this.seatBookingId = seatBookingId; 
            this.status = status;
            this.movie = movie;
            this.category = category;
            this.seats = seats;
            this.amount = amount;
        }   
    }
}