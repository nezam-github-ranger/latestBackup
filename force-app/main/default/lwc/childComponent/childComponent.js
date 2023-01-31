import { LightningElement, api, track, wire } from 'lwc';

export default class ChildComponent extends LightningElement {

    @api recordId;
    @api objectApiName;

    connectedCallback(){
        console.log('record Id ==> ' + this.recordId);
        console.log('object name ==> ' + this.objectApiName);
    }


}