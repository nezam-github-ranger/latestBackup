import { LightningElement, track, wire, api} from 'lwc';
import pubsub from 'c/pubsub';
import fetchSeatCategoryDetails from '@salesforce/apex/TheaterSeatCategoryDetails.fetchSeatCategoryDetails';
import fetchSelectedSeats from '@salesforce/apex/TheaterSeatCategoryDetails.fetchSelectedSeats';

export default class ScreenAndTotalSeats extends LightningElement {

    seatShowList;
    sendSeatAndCategory;
    parameters = {};
    sendSelectedMovieId;
    bookedSeatsList;
    check = false;
    
    bronze = 0;
    silver = 0;
    gold = 0;
    platinum = 0;

    connectedCallback(){
        this.parameters = this.getQueryParameters();
        console.log('params ==> ',this.parameters);
        this.sendSelectedMovieId = this.parameters.id;
    }

    @wire(fetchSeatCategoryDetails)
    records({error,data}){
        if(data){
            this.seatShowList = data;
            console.log('seatShowList ==> ', this.seatShowList);
            this.fetchSelectedMovie();
        }
        else if(error){
            console.log("error ==> ", error);            
        }
    }
    fetchSelectedMovie(){
        fetchSelectedSeats({ selectedMovieId: this.sendSelectedMovieId })
            .then((result) => {
                console.log('result ==> ', result);
                this.bookedSeatsList = result;
                console.log('bookedSeatsList ==> ', this.bookedSeatsList);
                
                this.selectedSeats(this.seatShowList , this.bookedSeatsList);
            })
            .catch((error) => {
                console.log('error ==> ', error);
            });
    }

    selectHandle(event){
        console.log('event.target.style.background   ==> ', event.target.style.background);
        let classList = event.target.classList;
        if((!classList.contains('selected_seat')) && (this.bronze < 10) && (this.gold < 6) && (this.silver < 8) && (this.platinum < 4)){
            console.log('upper if',event.target.style.background);
            if(event.target.style.background === 'rgb(8, 114, 8)'){
                event.target.style.background = "orange";
                this.selectedSeats(this.seatShowList , this.bookedSeatsList);
                this.sendSeatAndCategory = {category: event.target.title, seat: event.currentTarget.dataset.label, price: event.currentTarget.dataset.price, categoryId: event.currentTarget.dataset.categoryid, seatId: event.currentTarget.dataset.seatid};
                if(event.target.title === "BRONZE"){        this.bronze++;      }
                if(event.target.title === "SILVER"){        this.silver++;      }
                if(event.target.title === "GOLD"){          this.gold++;        }
                if(event.target.title === "PLATINUM"){      this.platinum++;    }

                console.log('sendSeatAndCategory ==> ', this.sendSeatAndCategory);
                pubsub.publish("data", this.sendSeatAndCategory);
            }
        }
        else{
            alert('Seat select limitation is exist....!!');
        }
    }

    selectedSeats(seats , occupiedSeats){
        seats.forEach((seat) => occupiedSeats.forEach((selectedSeat)=> {
            if(seat.Id === selectedSeat.Seat_Category__c){
                seat.Seats__r.forEach(element => {
                    if(element.Id === selectedSeat.Seat__c){
                        let selectedElements = this.template.querySelectorAll('[data-seatid = ' + element.Id + ']');
                        selectedElements.forEach(element=>{
                            element.classList.add('selected_seat');                        
                        });
                    }
                })
            }   
        }));
    }

    getQueryParameters() {
        var params = {};
        var search = location.search.substring(1);

        if(search) {
            params = JSON.parse('{"' + search.replace(/&/g, '","').replace(/=/g, '":"') + '"}', (key, value) => {
                return key === "" ? value : decodeURIComponent(value)
            });
        }
        return params;
    }
}