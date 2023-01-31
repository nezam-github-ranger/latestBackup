import { LightningElement, wire, track } from 'lwc';
import getContactRecords from '@salesforce/apex/ContactController.getContactRecords';

export default class WireComponent extends LightningElement {

    value = '';

    get options() {
        return [
            { label: 'Dickenson plc', value: 'Dickenson plc' },
            { label: 'University of Arizona', value: 'University of Arizona' },
            { label: 'Burlington Textiles And Crop', value: 'Burlington Textiles And Crop' },
            { label: 'United Oil & Gas, Singapore', value: 'United Oil & Gas, Singapore'},
						
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }
    
    @wire(getContactRecords)
    contactList;

    /*handleContact(obj){
        if(obj.data){
            this.contactList = obj.data.filter(item => {
                return;
            });
        }
    }*/    
    
}