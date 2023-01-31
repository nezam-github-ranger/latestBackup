import { LightningElement, api } from 'lwc';
export default class ChildComponentBasic extends LightningElement {

    @api childVarInput;
    vinod = 'abc';

    handleInput(event){
        this.childVarInput = event.target.value;
        console.log('childVarInput ==> ', this.childVarInput);

        const custEvent = new CustomEvent(
            'callpasstoparent', { 
            detail: this.childVarInput 
        });
        this.dispatchEvent(custEvent);
        console.log('dispatch run');
    }
}