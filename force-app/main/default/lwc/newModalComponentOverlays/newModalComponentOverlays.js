import { LightningElement } from 'lwc';
import { api } from 'lwc';
import LightningModal from 'lightning/modal';

export default class NewModalComponentOverlays extends LightningModal {

    handleOkay() {
        this.close('okay');
    }
}