import { LightningElement, api, track, wire} from 'lwc';
import forgotPasswordMethod from '@salesforce/apex/ForgotPasswordCustomController.forgotPassword';

export default class ResetUser extends LightningElement {

    userName = '';

    usernameHandle(event){
        console.log('username ==> ', this.userName);
        this.userName = event.target.value;
        console.log('username ==> ', this.userName);
    }

    resetPassword(){ 
        console.log('username in reset ==> ', this.userName);
        //if(userName === undefined || userName == null || userName.length <= 0){

        //}else{
            forgotPasswordMethod({ username: this.userName})
                .then(result => {
                    console.log('result ==> ', result);
                })
                .catch(error => {
                    console.log('error ==> ', error);
            });
        //}
    }

    cancel(){

    }

}