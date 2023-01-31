import { LightningElement, wire, api, track} from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import STATUS from '@salesforce/schema/Project__c.Status__c'; 
import getProjects from '@salesforce/apex/ProjectProgressBarController.getProjects';

export default class ProgressBar extends LightningElement {
    //@track currentStep;
    @api recordId;
    //@track projectList;

    //@wire(getProjects, {recordId:'$recordId'})
    @wire (getRecord, {recordId : '$recordId', fields : STATUS})
    project;

    get Status(){
        return getFieldValue(this.project.data, STATUS);    
    }
    /*projectListFilling({ error, data }) {
        if (data) {
            this.projectList = data;
            this.currentStep = this.projectList[0].Status__c;
            console.log('current step ==> ',this.currentStep)
            
            //this.handleCurrentStep();
        } else if (error) {
            console.log(error)
        }
    }*/

}