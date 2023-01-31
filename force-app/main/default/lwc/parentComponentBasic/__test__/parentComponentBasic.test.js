import { createElement } from "lwc";
import ParentComponentBasic from 'c/parentComponent';

describe('c-parent-component-basic test suite', ()=>{

    beforeEach(() =>{
        const element = createElement('c-parent-component-basic', {
            is:ParentComponentBasic
        });
        document.body.appendChild(element)
    })

    test('test data from child is available', ()=>{
        const element = document.querySelector('c-parent-component-basic')
        const childCmpElement = element.shadowRoot.querySelectorAll('c-child-component-basic')
        expect(childCmpElement.length).toBe(0)
    })

    /*test('test data from child is same', ()=>{
        const element = document.querySelector('c-parent-component-basic')
        const childCmpElement = element.shadowRoot.querySelector('c-child-component-basic')
        //childCmpElement.passToParent = 'Test Data';
        const divElement = element.shadowRoot.querySelector('.valuesFromChild');
        expect(divElement.textContent).toBe('Values From Child ==> ')
    })*/

})