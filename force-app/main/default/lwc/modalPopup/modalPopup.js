import { LightningElement, track } from 'lwc';
export default class ModalPopup extends LightningElement {
    
    _handler

    // connectedCallback() {
    //     console.log('connectedCallback');
    //     document.addEventListener('click', this._handler = this.close.bind(this));
    //     console.log('in log ==> ', document.addEventListener('click', this._handler = this.close.bind(this)));
    // }

    // disconnectedCallback() {
    //     console.log('disconnectedCallback');
    //     document.removeEventListener('click', this._handler);
    //     console.log('in log ==> ', document.removeEventListener('click', this._handler));
    // }

    //================================== first popup ====================================

    @track isModalOpen = false;
    openModal() {
        this.isModalOpen = true;
    }
    
    outsideOfPopup(){
        console.log('outsideOfPopup');
    }

    closeModal(event) {
        console.log('event ==> ', event);
        console.log('closeModal ==> ', event.target.class);
        this.isModalOpen = false;
    }

    submitDetails() {
        this.isModalOpen = false;
    }

    //=================================== second popup =====================================

    @track isShowModal = false;
    showModalBox() {  
        this.isShowModal = true;
    }

    hideModalBox() {  
        this.isShowModal = false;
    }

    
}