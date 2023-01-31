import { LightningElement, track, api } from 'lwc';

export default class ParentCountryComponent extends LightningElement {

    value = '';
    isClickShowButton = false;

    get options() {
        return [
            { label: 'India', value: 'India' },
            { label: 'Pakistan', value: 'Pakistan' },
            { label: 'England', value: 'England' }
        ];
    }
    /*countryObj = [
        {
            countryName : "India",
            capital : "Delhi",
            population : 124500,
            president : "Narendra Modi"
        },
        {
            countryName : "Pakistan",
            capital : "Kranchi",
            population : 198500,
            president : "Irfan Khan"
        },
        {
            countryName : "England",
            capital : "Sydney",
            population : 13300,
            president : "Edna Frank"
        }

    ]
    */

    handleChange(event) {
        this.value = event.detail.value;
    }
    handleClick(event){
        if(this.value != ''){
            this.isClickShowButton = true;
            //this.template.querySelector('c-child-country-component').countryname = 'abc';
            this.template.querySelector('c-child-country-component').resetCountry();
        }
    }

}