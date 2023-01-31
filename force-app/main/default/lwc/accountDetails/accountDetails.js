import { LightningElement, api, track, wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import OBJECT_NAME from '@salesforce/schema/Account';
import FIELD_API_NAME from '@salesforce/schema/Account.Industry';

export default class MyComponent extends LightningElement {

    @track options;

    
    connectedCallback() {
        
    }

    handleIndustryChange() {
       
    }
}
