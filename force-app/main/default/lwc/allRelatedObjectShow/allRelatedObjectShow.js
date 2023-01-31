import { LightningElement, track } from 'lwc';
import Contact_Custom_Label from '@salesforce/label/c.Contact_Custom_Label';
import opportunityLable from '@salesforce/label/c.Opportunity_Custom_Label';
import 	Task_Custom_Label from '@salesforce/label/c.Task_Custom_Label';
import Attachment_Custom_Label from '@salesforce/label/c.Attachment_Custom_Label';


const NUM_OF_TABS = 4;

export default class AllRelatedObjectShow extends LightningElement {

    @track selectedObject = 'Contact';
    @track selectedFieldSet =  'Show_Fields_In_Lwc';

    get tabs() {
        console.log('getter called',this.selectedObject);
        return [
            {
                value: `Contact`,
                label: Contact_Custom_Label,
                fieldset : 'Show_Fields_In_Lwc'
            },
            {
                value: `Opportunity`,
                label: opportunityLable,
                fieldset : 'Show_Fields_In_Lwc_Opportunity'
            },
            {
                value: `Task`,
                label: Task_Custom_Label,
                fieldset : 'Show_Fields_In_Lwc_Task'
            },
            {
                value: `Attachment`,
                label: Attachment_Custom_Label,
                fieldset : 'None'
            }
        ];
    }

    handleActive(event) {
        this.selectedObject = event.target.value;
        this.selectedFieldSet = event.target.dataset.fieldset;
        console.log('selectedObject  => ', this.selectedObject);
        console.log('selectedFieldSet  => ', this.selectedFieldSet);
        
    }  
    connectedCallback(){
        console.log('selectedObject in connected => ', this.selectedObject);
        
    }
    

}