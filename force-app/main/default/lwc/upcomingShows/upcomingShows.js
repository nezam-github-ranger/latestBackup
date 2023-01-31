import { LightningElement, wire, api } from 'lwc';
import fetchRecord from '@salesforce/apex/TheaterMovieDetails.fetchMoviesDetails';

export default class UpcomingShows extends LightningElement {

    moviesDetails; 
    pushArray;

    @wire(fetchRecord)
    records({error,data}){
        if(data){
            console.log("data ==> ", data);
            this.moviesDetails = data;
            
            this.moviesDetails = this.moviesDetails.map(row => ({
                ...row,
                imageUrl : '/sfc/servlet.shepherd/version/download/' + row.pictures,
              }));

            console.log('pushArray ==> ', this.pushArray); 
        }
        else if(error){
            console.log("error ==> ", error);            
        }
    }

}