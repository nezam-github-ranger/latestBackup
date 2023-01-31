import { LightningElement } from 'lwc';

export default class ChildNumberOfCountry extends LightningElement {

    checkValue = '';
    /*get options() {
        return [
            { label: 'Select', value: 'option1' },
        ];
    }

    get selectedValues() {
        return this.value.join(',');
    }*/

    handleChange(e) {
        console.log('--> ',e.target.value);
        if(this.checkValue.includes(e.target.value)){
            console.log('val ==> ', e.target.value);
            this.checkValue = this.checkValue.replace(e.target.value + ',','');
        }
        else{
            this.checkValue += e.target.value + ', ';
        }
        //this.checkValue += e.target.value + ', '
    }

    handleClick(e){
        console.log('handle click call');
        const selectedVal = new CustomEvent("nezam",{
            detail : this.checkValue  
        })  
        this.dispatchEvent(selectedVal);    
    }

}