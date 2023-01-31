import { LightningElement } from 'lwc';
import NewModalComponentOverlays from 'c/newModalComponentOverlays';

export default class OpenPopUpModal extends LightningElement {
    result;
    async openModal(){
        const result = await NewModalComponentOverlays.open({
            size : "Large",
            description : "This is a modal popup",
            title : "This is the title of Modal"
        });
        this.result = result;
        console.log('this.result ==> ', this.result);
    }
}