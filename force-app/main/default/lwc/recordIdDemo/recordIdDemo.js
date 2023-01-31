import { LightningElement, api, track, wire } from 'lwc';
import GET_PRODUCT from '@salesforce/apex/AccountListComponentCls.getProduct';
export default class RecordIdDemo extends LightningElement {

    @api recordId;
    product;

    // @wire(GET_PRODUCT, {recId: '$recordId'}) 
    // WireContactRecords({error, data}){
    //     console.log('WireContactRecords ==> ' + this.WireContactRecords);
    //     console.log('WireContactRecords ==> ' + this.WireContactRecords);
    //     console.log('recordId ==> ' + '$recordId');
    //     if(data){
    //         console.log('data ==> ' + data);
    //         this.product = data;
    //     }else{
    //         console.log('error ==> ' + error);
    //         this.product = error;
    //     }
    // }  
        
    connectedCallback() {
        console.log('recordId ==> ' + this.recordId);
        console.log('product ==> ' + this.product);
        
        GET_PRODUCT({recId : this.recordId})
            .then(result => {
                console.log('result ==> ' + result);
                this.product = result;
            })
            .catch(error => {
                console.log('error ==> ' + error);
            });
    }
}