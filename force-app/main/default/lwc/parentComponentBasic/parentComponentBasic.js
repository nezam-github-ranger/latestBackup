import { LightningElement, track } from 'lwc';
export default class ParentComponentBasic extends LightningElement {

    @track barVal = 'default value';
    passToParent(event){
        console.log('in parent ==> ', event.detail);
        this.barVal = event.detail;
    
    }

}