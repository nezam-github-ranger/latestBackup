import { LightningElement ,api } from 'lwc';
export default class ParentComponent extends LightningElement {
    @api recordId;

    connectedCallback(){
        console.log("RecordId", this.recordId );
        
    }
}