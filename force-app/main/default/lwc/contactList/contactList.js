import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import FIRST_NAME from '@salesforce/schema/Contact.FirstName';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import EMAIL from '@salesforce/schema/Contact.Email';
    const columns = [
    { label: 'FirstName', fieldName: FIRST_NAME},
    { label: 'LastName', fieldName: LAST_NAME},
    { label: 'Email', fieldName: EMAIL},
];

export default class ContactList extends LightningElement {

    columns = columns;

    @wire(getContacts)
    data;
}