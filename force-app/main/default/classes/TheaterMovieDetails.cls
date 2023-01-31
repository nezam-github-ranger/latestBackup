/*
    Name	 	:  TheaterMovieDetails 
	Project     :  Book My Show
    Date 		:  29 April, 2021
    Author 		:  Nezam Uddin
    Description :  This class is used to fetch all the images of the movies and also fetch the movies details. In this class have a wrapper class this wrapper is used to wrap the data of movies and their images.
*/

public without sharing class TheaterMovieDetails {
	
    @AuraEnabled(cacheable = true)	 
    public static List<TheaterAndAttacmentWrapper> fetchMoviesDetails(){
        Map<Id, Movies__c> moviesMap = new Map<Id, Movies__c>([SELECT Id, Name, Start_Time__c FROM Movies__c]);
        
        List<TheaterAndAttacmentWrapper> theaterAndAttachmentWrapperList = new List<TheaterAndAttacmentWrapper>();
        Map<String, String> movieIdAndContentDocumentMap = new  Map<String, String>();
        Map<String, List<String>> movieAndContentVersionIdMap = new Map<String,  List<String>>();
        System.debug('moviesMap.keySet()' + moviesMap.keySet());
        
        for(ContentDocumentLink cdl : [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN: moviesMap.keySet()]) {
            //cdl.Visibility = 'AllUsers';
            movieIdAndContentDocumentMap.put(cdl.ContentDocumentId, cdl.LinkedEntityId);
        }         
        for(ContentVersion cv: [SELECT Id, ContentDocumentId FROM ContentVersion WHERE ContentDocumentId IN: movieIdAndContentDocumentMap.keySet()]){
            String movieId = movieIdAndContentDocumentMap.get(cv.ContentDocumentId);
            if(movieAndContentVersionIdMap.containsKey(movieId)){
                movieAndContentVersionIdMap.get(movieId).add(cv.Id);
            }else{
                movieAndContentVersionIdMap.put(movieId, new List<String>{cv.Id});
            }
        } 
       
        for(Id productId : moviesMap.keySet()){
            theaterAndAttachmentWrapperList.add(new TheaterAndAttacmentWrapper(moviesMap.get(productId),(movieAndContentVersionIdMap.containsKey(productId) ? movieAndContentVersionIdMap.get(productId) : new List<String>())));
        }
        System.debug('theaterAndAttachmentWrapperList ==> ' + theaterAndAttachmentWrapperList);
        return theaterAndAttachmentWrapperList;
    }
    
    public class TheaterAndAttacmentWrapper{
        @AuraEnabled public Movies__c moviesObject;
        @AuraEnabled public List<String> pictures;
        
        public TheaterAndAttacmentWrapper(Movies__c moviesObject, List<String> pictures){
            
            this.moviesObject = moviesObject;
            this.pictures = pictures;
            
        }
    }
}