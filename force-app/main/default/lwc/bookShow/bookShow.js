import { LightningElement,track, wire} from 'lwc';
import pubsub from 'c/pubsub';
import insertRecord from '@salesforce/apex/TheaterInsertBooking.insertRecord';

export default class BookShow extends LightningElement {

    parameters = {};

    @track bronzeList = [];
    @track bronzeAmount = 0;
    @track bronzeSelectedSeat = 0;

    @track silverList = [];
    @track silverAmount = 0;
    @track silverSelectedSeat = 0;

    @track goldList = [];
    @track goldAmount = 0;
    @track goldSelectedSeat = 0;

    @track platinumList = [];
    @track platinumAmount = 0;
    @track platinumSelectedSeat = 0;

    @track totalAmount = 0;
    @track bookingDate;

    selectedSeatWithCategory = [];

    connectedCallback(){
        this.screenAndSeatLoad();
        this.parameters = this.getQueryParameters();
        console.log('params ==> ',this.parameters);
        if(this.parameters && Object.keys(this.parameters).length === 0 && this.parameters.constructor === Object){
            console.log('empty');
            window.alert("Please Select The Movie First...!!!");
            window.location.href = "https://communitydomaindemo-developer-edition.ap24.force.com/theater/s/";
        }
    }

    screenAndSeatLoad(){
        pubsub.subscribe("data", message => {
            console.log("Catch Message : ", message);
        
            this.selectedSeatWithCategory.push({Seat_Category__c: message.categoryId, Seat__c: message.seatId, Amount__c: message.price});
            console.log('selectedSeatWithCategory  ==> ', this.selectedSeatWithCategory);
            
            if(message.category === "BRONZE"){
                this.bronzeAmount = message.price;
                this.bronzeList.push(message);
                this.bronzeSelectedSeat = this.bronzeList.length;
                this.bronzeAmount *= this.bronzeSelectedSeat;
            }
            else if(message.category === "SILVER"){
                this.silverAmount = message.price;
                this.silverList.push(message);
                this.silverSelectedSeat = this.silverList.length;
                this.silverAmount *= this.silverSelectedSeat;
            }
            else if(message.category === "GOLD"){
                this.goldAmount = message.price;
                this.goldList.push(message);
                this.goldSelectedSeat = this.goldList.length;
                this.goldAmount *= this.goldSelectedSeat;
            }
            else if(message.category === "PLATINUM"){
                this.platinumAmount = message.price;
                this.platinumList.push(message);
                this.platinumSelectedSeat = this.platinumList.length;
                this.platinumAmount *= this.platinumSelectedSeat;
            }
            this.totalAmount = this.bronzeAmount + this.silverAmount + this.goldAmount + this.platinumAmount;

        });
    }

    handleSectedDate(event){
        console.log('date ==> ', event.target.value);
        console.log('current Date  ==> ', new Date().toISOString().split('T')[0]);

        this.bookingDate = event.target.value;
        console.log('current date ==> ', new Date().toISOString().split('T')[0]);
        if(this.bookingDate < new Date().toISOString().split('T')[0]){
            this.bookingDate = null;
            alert('Cannot select the past date movie....!!');
        }
        
        var myDate = new Date(new Date().getTime()+(7*24*60*60*1000));
        console.log('five days after date ==> ', myDate);
        console.log('converted date  ==> ',  myDate.toISOString().split('T')[0]);

        if(this.bookingDate > myDate.toISOString().split('T')[0]){
            alert('Cannot select more than 7 days movie...!!');
            this.bookingDate = null;
        }
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

    handleCheckout(){
        console.log('handle checkout  id ==> ', this.parameters.id);
        console.log('handle bookingDate  ==> ', this.bookingDate);
        
        if(this.totalAmount > 0){
            let bookingObj = {Movie__c: this.parameters.id, Booking_Date__c: this.bookingDate}
            
            console.log('selectedSeatWithCategory  ==> ', this.selectedSeatWithCategory);
            console.log('bookingObj  ==> ', bookingObj);

            insertRecord({bookingInsert : bookingObj, selectedSeat: this.selectedSeatWithCategory})
            .then(result => {
                console.log('result ==> ', result);
                alert('Movies Booked Successfully....!!!');
                location.reload();
            })
            .catch(error => {
                console.log('error  ==> ', error);
            });
        }
        else{
            alert('Please select the seat first...!!');
        }
    }
}