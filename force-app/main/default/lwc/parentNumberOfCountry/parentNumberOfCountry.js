import { LightningElement } from 'lwc';

export default class ParentNumberOfCountry extends LightningElement {

    isSubmitClick = false;
    countryNames = '';
    numberOfCountry = 0;

    showDetails(event){
        console.log('event call', event.detail);
        if(event.detail != ''){
            this.isSubmitClick = true;
            this.countryNames = event.detail;      
        }
        console.log('country Name => ', this.countryNames);
        let arr = this.countryNames.split(',');
        this.numberOfCountry = arr.length - 1;
    }

}