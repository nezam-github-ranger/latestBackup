import { LightningElement, track, wire, api } from 'lwc';
import fetchMoviesDetails from '@salesforce/apex/TheaterMovieDetails.fetchMoviesDetails';
import { NavigationMixin } from 'lightning/navigation';
//import getUserInfo from '@salesforce/apex/UserDetails.getUserInfo';
//import FIELD_NAME from '@salesforce/schema/object.fieldApiName';

export default class MovieGrid extends NavigationMixin(LightningElement)  {

    moviesDetails; 
    
    @wire(fetchMoviesDetails)
    records({error,data}){
        if(data){
            console.log("data ==> ", data);
            this.moviesDetails = data;
            this.moviesDetails = this.moviesDetails.map(row => ({
                ...row,
                imageUrl : '/sfc/servlet.shepherd/version/download/' + row.pictures,
                
            }));
        }
        else if(error){
            console.log("error ==> ", error);            
        }
    }

    handleClick(event){
        this[NavigationMixin.Navigate]({
            "type" : "standard__webPage",
            "attributes" : {
                "url" : "/theater/s/seat-book/?name=" + event.target.title + "&image=" + event.currentTarget.dataset.label + "&time=" + event.currentTarget.dataset.time + "&id=" + event.currentTarget.dataset.id
            }
        });
    }
   
}