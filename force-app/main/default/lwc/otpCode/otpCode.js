import { LightningElement, api, track   } from 'lwc';
export default class OtpCode extends LightningElement {

    @track storeAllOTPValues = [
        {
            class : 'classInputli1',
            name : 'classInputli1',
            id : 'otp1',
            type : 'text',
            maxlength : '1',
            style : "width: 80px !important;",
            onkeyup : 'handleOTP1',
            value: ''
        },
        {
            class : 'classInputli2',
            name : 'classInputli2',
            id : 'otp2',
            type : 'text',
            maxlength : '1',
            style : "width: 80px !important;",
            onkeyup : 'handleOTP1',
            value: ''
        },
        {
            class : 'classInputli3',
            name : 'classInputli3',
            id : 'otp3',
            type : 'text',
            maxlength : '1',
            style : "width: 80px !important;",
            onkeyup : 'handleOTP1',
            value: ''
        },
        {
            class : 'classInputli4',
            name : 'classInputli4',
            id : 'otp4',
            type : 'text',
            maxlength : '1',
            style : "width: 80px !important;",
            onkeyup : 'handleOTP1',
            value: ''
        }
    ];

    handleOTP1(event){
        //console.log(' event.StopPropogation() ==> ', event.preventDefault());
        let newNameVar = event.target.name.substring(0, event.target.name.length - 1);
        const lastDigit =  parseInt(event.target.name.charAt(event.target.name.length - 1)) + 1;
        newNameVar = newNameVar + lastDigit;
        console.log('finalyy  ==> ', newNameVar);
        if(event.target.value !=  null || event.target.value != ''){
            console.log('in if ==> ', event.target.value);
            newNameVar = newNameVar.trim(); 
            console.log('newNameVar ==> ', newNameVar);
            
            this.storeAllOTPValues[lastDigit-2].value = event.target.value;
            this.template.querySelector('.' + newNameVar).focus();
        }
        console.log('this.storeAllOTPValues ==> ', this.storeAllOTPValues);
    }

    handleContinue(event){
        console.log('in handleContinue Method');
        this.storeAllOTPValues.forEach(currentItem => {
            currentItem.value = '';
        });
        console.log('this.storeAllOTPValues ==> ', this.storeAllOTPValues);
        this.template.querySelector('.classInputli1').focus();

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