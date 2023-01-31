import { LightningElement } from 'lwc';

export default class DynamicCSSComponent extends LightningElement {
    
    handleValue(event)
    {
       
        //String interpolation
        const myDiv = this.template.querySelector('.myDiv');
        myDiv.setAttribute('style','width:'+event.target.value+'%');
    }
}