import { LightningElement, api, wire, track} from 'lwc';
import getAccountRelatedRecords from '@salesforce/apex/AccountRelatedObjectFetchController.getRelatedObjectRecord';

export default class AccountRelatedObjectDetails extends LightningElement {
    @api selectedObject;
    @api selectedFieldSet;
    @track showData;
    columns;
   
    @wire(getAccountRelatedRecords, {objectName : '$selectedObject', selectedFieldSet : '$selectedFieldSet'})
    record ({error, data}) {
        if (error) {
            console.log("error ==> ", error);
        }else if (data) {
            console.log("data contact....==> ", data);
            this.columns = data[0].columnList;
            console.log('columns => ', this.columns);
            console.log("selectedObject ==>", this.selectedObject)
            this.showData = data[0].listOfsObject;
            console.log("showData => ", this.showData);
        }
    }

    connectedCallback() {
        console.log('selectedObject In connected ==> ', this.selectedObject);
        console.log('selectedFieldSet In connected ==> ', this.selectedFieldSet);
        /*if(this.selectedObject === 'Attachment'){
            this.columns = [
                { label: 'Id', fieldName: 'Id' },
                { label: 'Name', fieldName: 'Name'},
                { label: 'Body', fieldName: 'Body'},
                { label: 'ContentType', fieldName: 'ContentType'}
            ];   
        }*/
    }
}