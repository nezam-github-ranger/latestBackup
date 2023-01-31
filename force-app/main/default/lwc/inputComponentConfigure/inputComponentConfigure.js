import { LightningElement, api } from 'lwc';

export default class InputComponentConfigure extends LightningElement {

    @api first_name;
    @api disabledVal;
    @api requiredVal;
    @api records;
    fristFaxNumber;
    secondFaxNumber;
    thirdFaxNumber;

    @api otpVal1 = '';
    @api otpVal2;
    @api otpVal3;
    @api otpVal4;

    storeAllOTPValues = [];


    get marginClass1(){
        //return this.requiredVal ? 'class1': 'class1';
        return 'class1';
    }

    get classTwo(){
        return 'classTwoCss';
    }

    connectedCallback(){
        this.faxValue();
        this.requiredCss();

    }

    faxValue(){
        if(typeof this.records != "undefined"){
            this.fristFaxNumber = this.records.substr(0, 3);
            this.secondFaxNumber = this.records.substr(3,3);
            this.thirdFaxNumber = this.records.substr(6,3);
        }
    }

    requiredCss(){
        if(typeof this.requiredVal != "undefined"){
            const theDiv = this.template.querySelector('[data-id="marginDiv"]');
            console.log('theDiv ==> ', theDiv);
            //theDiv.className = 'marginCss';
        }
    }

    renderedCallback(){
        // console.log('js call first_name ==> ', this.first_name);
        // console.log('record ==> ', this.records);
        
    }

    handleOTP1(event){
        console.log(' event.StopPropogation() ==> ', event.preventDefault());
        let newNameVar = event.target.name.substring(0, event.target.name.length - 1);
        const lastDigit =  parseInt(event.target.name.charAt(event.target.name.length - 1)) + 1;
        newNameVar = newNameVar + lastDigit;
        console.log('finalyy  ==> ', newNameVar);
        if(event.target.value !=  null || event.target.value != ''){
            this.storeAllOTPValues[lastDigit-2] = event.target.value;
            this.template.querySelector('.' + newNameVar).focus();
        }
        console.log('this.storeAllOTPValues ==> ', this.storeAllOTPValues);
    }

    callOnKeyUp(event){
        console.log('callOnKeyUp Handle OTP 1 Method');
        console.log('callOnKeyUp id ==> ', event.target.id);
        console.log('callOnKeyUp value ==> ', event.target.value);
        console.log('callOnKeyUp name ==> ', event.target.name);
        console.log('callOnKeyUp class ==> ', event.target.class);
        console.log('callOnKeyUp id input ==> ', document.querySelector('.classInput1')); 
        console.log('callOnKeyUp id input temp ==> ', this.template.querySelector('.classInput1'));
        this.template.querySelector('.classInput2').focus();
        console.log('callOnKeyUp id input last');

    }

}