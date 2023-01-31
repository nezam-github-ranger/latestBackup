import {createElement} from 'lwc';
import HelloWorld from 'c/helloWorld';

const EXPECT = [
    'Name : Jatin',
    'Name : Rahul',
    'Name : Sanjay'
]

describe('c-hello-world test suite', ()=>{

    beforeEach(() =>{
        const element = createElement('c-hello-world', {
            is:HelloWorld
        })
        document.body.appendChild(element)
    })

    test('display first div', ()=>{
        const element = document.querySelector('c-hello-world')
        const firstDiv = element.shadowRoot.querySelector('.firstDiv')
        expect(firstDiv.textContent).toBe('Hello, LWC ClassHi, LWC Class')        
    })

    test('display second div', ()=>{
        const element = document.querySelector('c-hello-world')
        const secondDiv = element.shadowRoot.querySelector('.secondDiv')
        expect(secondDiv.textContent).toBe('Hello Dear, Go')
    })

    it('display false div', ()=>{
        const element = document.querySelector('c-hello-world')
        const falseDiv = element.shadowRoot.querySelector('.divForRendering')
        expect(falseDiv.textContent).toBe('It is false') 
    })

    
    it('display true div by checkbox', ()=>{
        const element = document.querySelector('c-hello-world')
        const lightningInputCheckbox = element.shadowRoot.querySelector('lightning-input')
        lightningInputCheckbox.checked = true;
        lightningInputCheckbox.dispatchEvent(new CustomEvent('change'))

        return Promise.resolve().then(()=>{
            const trueDivElement = element.shadowRoot.querySelector('.divForRendering')
            expect(trueDivElement.textContent).toBe('It is true')     
        })
    })

    /*it('display true div by button', ()=>{
        const element = document.querySelector('c-hello-world')
        const lightningInputButton = element.shadowRoot.querySelector('lightning-button')
        //lightningInputButton.checked = true;
        lightningInputButton.dispatchEvent(new CustomEvent('click'))

        return Promise.resolve().then(()=>{
            const trueDivElement = element.shadowRoot.querySelector('.divForRendering')
            expect(trueDivElement.textContent).toBe('It is true')     
        })
    })*/

    
    it('check list data by using length', ()=>{
        const element = document.querySelector('c-hello-world')
        const iteratorValues = element.shadowRoot.querySelectorAll('.iteratorList>li')
        expect(iteratorValues.length).toBe(3);
    })

    it('check list data by using values', ()=>{
        const element = document.querySelector('c-hello-world')
        const iteratorValues = Array.from(element.shadowRoot.querySelectorAll('.iteratorList>li'))
        const userList = iteratorValues.map(li=>li.textContent)
        expect(userList).toEqual(EXPECT);
        //toStrictEqual - toEqual :- both method are used on array
    })

    it('check only first li data', ()=>{
        const element = document.querySelector('c-hello-world')
        const iteratorValues = element.shadowRoot.querySelector('.ulList>li:first-child>div:first-child')
        expect(iteratorValues.textContent).toEqual('This is 0 Div');
        //toStrictEqual - toEqual :- both method a3re used on array
    })

})
