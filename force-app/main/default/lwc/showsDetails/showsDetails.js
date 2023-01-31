import { LightningElement, wire } from 'lwc';
import fetchSeatCategoryDetails from '@salesforce/apex/TheaterShowsDetails.fetchSeatCategoryDetails';
import userBookingCancel from '@salesforce/apex/TheaterUserBookingCancel.userBookingCancel';

export default class ShowsDetails extends LightningElement {

    activeSections = 'A';
    previous;
    showData;
    
    upcomingShows = [];
    completedShows = [];
    canceledShows = [];
    
    @wire(fetchSeatCategoryDetails)
    records({error,data}){
        if(data){
            console.log('data ==> ', data); 
            data.forEach(element => {
                console.log('element ==> ', element.status);
                if(element.status === 'Completed'){
                    this.completedShows.push(element);    
                }
                else if(element.status === 'Upcoming'){
                    this.upcomingShows.push(element);
                }
                else if(element.status === 'Canceled'){
                    this.canceledShows.push(element);
                }
            });
            this.showData = data;

            console.log('completed shows  ==>  ', this.completedShows);
            console.log('upcoming  shows  ==>  ', this.upcomingShows);
            console.log('canceled  shows  ==>  ', this.canceledShows);
        }
        else if(error){
            console.log('error ==> ', error);
        }
    }
    handleCancel(event){
        console.log('cancel click ==> ', event.currentTarget.dataset.booking);
        userBookingCancel({bookingId : event.currentTarget.dataset.booking})
            .then(result => {
                console.log('result ==> ', result);
                if(result){
                    alert('Seat not canceled, because movie is currenty in running...!!');
                }
                else{
                    alert('Seat cancel successfully...!!');
                    location.reload();

                }
            })
            .catch(error => {
                console.log('error  ==> ', error);
            });
    }
}