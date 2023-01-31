import { LightningElement, track } from 'lwc';
import My_Resource from '@salesforce/resourceUrl/modelTickLogo';

export default class ModelComponent extends LightningElement {

    modelLogo = My_Resource;
    @track isShowModal = false;
    renderedCallback(){
        console.log('modelLogo : ',this.modelLogo);
    }
    
    showModalBox() {
        this.isShowModal = true;
    }

    hideModalBox() {
        this.isShowModal = false;
    }
}