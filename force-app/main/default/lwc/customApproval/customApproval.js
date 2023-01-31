import { LightningElement, wire, track, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import fetchProcessInstance from '@salesforce/apex/ManageApprovalButton.fetchProcessInstance';
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

export default class CustomApproval extends LightningElement {

    record = [];
    columns = columns;
    approvalButton;
    approvalActionName;
    headerApprovalAction;
    @track isReassignShow = false;
    @track isCustomLookupShow = false;
    @track isCommentBoxShow = false;
    @track isModalOpen = false;
    @track reasignUserId = '';
    @track targetObjectId;
    @track wiredRecordList = [];
    commentValue;

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

    handleRowAction(event) {
        this.isModalOpen = true;
        this.isCommentBoxShow = true;
        this.targetObjectId = event.detail.row.Id;
        this.approvalActionName = event.detail.action.name;
        this.headerApprovalAction = event.detail.action.name;
        if (event.detail.action.name == 'Reassign') {
            this.isCustomLookupShow = true;
        }
        else {
            this.isReassignShow = false;
            this.isCommentBoxShow = false;
            this.isCustomLookupShow = false;
            this.approvalButton = event.detail.action.name;
        }
    }

    onHandleApproveReject() {
        let commentValue = this.template.querySelector('[data-id="textarea1"]').value;
        manageCustomApproval({ workItemId: this.targetObjectId, approvalAction: this.approvalActionName, comment: commentValue }).then(response => {
            this.showToast(this.approvalActionName);
            this.isModalOpen = false;
            return refreshApex(this.wiredRecordList);

        }).catch(error => {
            console.log('Error : ' + error);
        });

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
        console.log('in reassign method');
        reassignApprovalUser({ workItemId: this.targetObjectId, userToAssign: this.reasignUserId }).then(response => {
            console.log('Response : ' + response);
            this.isModalOpen = false;
            this.showToast('Reassign');
            return refreshApex(this.wiredRecordList);
        }).catch(error => {
            console.log('Error : ' + error);
        })
    }
}