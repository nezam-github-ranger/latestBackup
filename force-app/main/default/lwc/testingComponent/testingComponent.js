import { LightningElement, wire, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import fetchProcessInstance from '@salesforce/apex/ApprovalRecordFetch.fetchProcessInstance';
import manageCustomApproval from '@salesforce/apex/ManageApprovalButton.manageCustomApproval';
import reassignApprovalUser from '@salesforce/apex/ManageApprovalButton.reassignApprovalUser';

const actions = [
    { label: 'Approve', name: 'Approve' },
    { label: 'Reject', name: 'Reject' },
    { label: 'Reassign', name: 'Reassign' }
];

const columns = [
    { label: 'Related To', fieldName: 'RelatedName' },
    { label: 'Type', fieldName: 'TargetObject' },
    { label: 'Current Approver', fieldName: 'CurrentApprover' },
    { label: 'Original Approver', fieldName: 'OriginalApprover' },
    { label: 'Submited By', fieldName: 'SubmitedBy' },
    { label: 'Submited Date', fieldName: 'CreatedDate', type: 'date' },
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];

export default class TestingComponent extends LightningElement {

    record = [];
    columns = columns;
    isReassignShow = false;
    @track isModalOpen = false;
    @track reasignUserId = '';
    @track targetObjectId;
    @track wiredRecordList = [];

    @wire(fetchProcessInstance) approvalList(result) {
        this.wiredRecordList = result;
        console.log('result', result);
        if (result.data) {
            let tempList = [];
            console.log('result.data ==> ' + JSON.parse(JSON.stringify(result.data)));
            result.data.forEach(element => {
                let tempObj = {};
                tempObj.RelatedName = element.ProcessInstance.TargetObject.Name;
                tempObj.TargetObject = element.ProcessInstance.TargetObject.Type;
                tempObj.SubmitedBy = element.ProcessInstance.SubmittedBy.Name;
                tempObj.CreatedDate = element.ProcessInstance.CreatedDate;
                tempObj.CurrentApprover = element.Actor.Name;
                tempObj.OriginalApprover = element.OriginalActor.Name;
                tempObj.Id = element.Id;
                tempList.push(tempObj);
                console.log('temp list ==> ', tempList);
            });

            this.record = tempList;
        } else if (result.error) {
            console.log('result.error ==> ' + JSON.stringify(result.error));
        }
    }

    /*@wire(fetchProcessInstance) catchData({ data, error }) {
        if (data) {
            console.log(data);
            let tempList = [];
            data.forEach(element => {
                let tempObj = {};
                tempObj.RelatedName = element.ProcessInstance.TargetObject.Name;
                tempObj.TargetObject = element.ProcessInstance.TargetObject.Type;
                tempObj.SubmitedBy = element.ProcessInstance.SubmittedBy.Name;
                tempObj.CreatedDate = element.ProcessInstance.CreatedDate;
                tempObj.CurrentApprover = element.Actor.Name;
                tempObj.OriginalApprover = element.OriginalActor.Name;
                tempObj.Id = element.Id;
                tempList.push(tempObj);
            });
            this.wiredRecordList = tempList;
            this.record = tempList;
            console.log('record ==> ' + JSON.stringify(this.record));
        } else {
            console.log('Error ===> ', JSON.stringify(error));
        }
    }*/

    handleRowAction(event) {
        this.targetObjectId = event.detail.row.Id;
        if (event.detail.action.name == 'Reassign') {
            this.isModalOpen = true;
        }
        else {
            manageCustomApproval({ docId: event.detail.row.Id, approvalAction: event.detail.action.name }).then(response => {
                this.showToast(event.detail.action.name);
                return refreshApex(this.wiredRecordList);
            }).catch(error => {
                console.log('Error : ' + error);
            });
        }
    }

    showToast(msg) {
        const event = new ShowToastEvent({
            title: 'Approval Request',
            message: msg + ' Successfully !!!',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }

    closeModal() {
        this.isModalOpen = false;
    }

    onUserSelection(event) {
        this.reasignUserId = event.detail.selectedRecordId; 
        this.isReassignShow = this.reasignUserId != null ? true : false;
    }

    onHandleReassignUser() {
        console.log('reasignUserId ==> ', this.reasignUserId)
        if (this.reasignUserId == null) {
            const event = new ShowToastEvent({
                title: 'Approval Request',
                message: 'Please Select User !!!',
                variant: 'danger',
                mode: 'dismissable'
            });
            this.dispatchEvent(event);
            this.isModalOpen = false;
            //this.showToast('Reassign');
            return refreshApex(this.wiredRecordList);
        }
        else {
            reassignApprovalUser({ docId: this.targetObjectId, userToAssign: this.reasignUserId }).then(response => {
                console.log('Response : ' + response);
                this.isModalOpen = false;
                this.showToast('Reassign');
                return refreshApex(this.wiredRecordList);
            }).catch(error => {
                console.log('Error : ' + error);
            })
        }
    }
}