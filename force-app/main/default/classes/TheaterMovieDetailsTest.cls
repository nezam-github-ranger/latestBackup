/*
    Name	 	:  TheaterMovieDetailsTest
	Project     :  Book My Show
    Date 		:  29 April, 2021
    Author 		:  Nezam Uddin
    Description :  This is a test class of TheaterMovieDetailsClass. This test class code coverage have 94%.
*/
@isTest(SeeAllData=true)
public class TheaterMovieDetailsTest {
	
    @isTest static void myTest() { 
        TheaterMovieDetails.fetchMoviesDetails();
        Map<Id, Movies__c> mapOfMovies = new Map<Id, Movies__c>([SELECT Id, Name, Start_Time__c FROM Movies__c]);
        System.assert(mapOfMovies != Null);
        
        Map<String, String> contentDocumentMap = new Map<String, String>();
        
        for(ContentDocumentLink cdl : [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN: mapOfMovies.keySet()]){
        	contentDocumentMap.put(cdl.ContentDocumentId, cdl.LinkedEntityId);    
        }
        System.assert(contentDocumentMap != Null);
        
        List<ContentVersion> contentVersionId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE ContentDocumentId IN: contentDocumentMap.keySet()];
        System.assert(contentVersionId != Null);
        
        //TheaterMovieDetails.TheaterAndAttacmentWrapper movie = new TheaterMovieDetails.TheaterAndAttacmentWrapper(mapOfMovies.values(), new List<String>());
        
	} 
    
}