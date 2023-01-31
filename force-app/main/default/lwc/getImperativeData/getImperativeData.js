import { LightningElement, api } from 'lwc';
//import getSomeContact from '@salesforce/apex/AccountContactCountInLWCPage/getSomeContact';
import fetchSomeContact from '@salesforce/apex/TestDataForLWC.fetchSomeContact';

export default class GetImperativeData extends LightningElement {

    @api recordsList = [];
    @api message = "";
    @api error = "";

    handleClick(){
        fetchSomeContact({})
        .then((result) => {
            if (result.length === 0) {
                this.message = "No Records Found";
            } else {
                this.recordsList = result;
            }    
            console.log('recordsList ==> ', this.recordsList);
            console.log('message ==> ', this.message);
            console.log('error ==> ', this.error);
        })
        .catch((error) => {
            this.error = error;
        });
    }

}
