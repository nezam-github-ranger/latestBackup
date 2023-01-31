import { LightningElement, api, track } from 'lwc';

export default class ChildCountryComponent extends LightningElement {

    @api countryname = '';
   
    isIndia = false;
    isPakistan = false;
    isEngland = false;
    card = false;
    /*
    isIndia = this.countryname === 'India' ? true : false ;
    isPakistan = this.countryname === 'Pakistan' ? true : false ;
    isEngland = this.countryname === 'England' ? false : true
    */

    @api resetCountry(){
        console.log('after india', this.isIndia);
        this.card = true;
        if(this.countryname === 'India'){
            this.isPakistan = false;
            this.isEngland = false;
            this.isIndia = true;
            console.log('before india', this.isIndia);
        }
        else if(this.countryname === 'Pakistan'){
            console.log('after Pak', this.isPakistan);
            this.isPakistan = true;
            this.isEngland = false;
            this.isIndia = false;
            console.log('before Pak', this.isPakistan);
        }
        else if(this.countryname === 'England'){
            this.isPakistan = false;
            this.isEngland = true;
            this.isIndia = false;
        }
    }

    /*handleChange(e) {
        console.log(isIndia);
        if(this.countryname == 'India'){
            isIndia = true;
        }
    }*/
}