import { createElement } from 'lwc';
import GetImperativeData from 'c/getImperativeData';

describe('c-imperative-data-testing', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('displays data when fetched', () => {
        // Create initial element
        const element = createElement('c-imperative-data-testing', {
            is: GetImperativeData
        });
        document.body.appendChild(element);

        // Get button element
        const buttonEl = element.shadowRoot.querySelector('lightning-button');

        // Set up data
        element.recordsList = [{ Id: '123', Name: 'Test Record' }];

        // Simulate button click
        buttonEl.dispatchEvent(new CustomEvent('click'));

        // Return a promise to wait for any asynchronous DOM updates. Jest will automatically wait
        // for the Promise chain to complete before ending the test and fail the test if the promise
        // is rejected.
        return Promise.resolve().then(() => {
            const dataDivs = element.shadowRoot.querySelectorAll('.dataDiv');
            expect(dataDivs.length).toBe(1);
            expect(dataDivs[0].textContent).toBe('Name : Test Record');
        });
    });

    it('displays error message', () => {
        // Create initial element
        const element = createElement('c-imperative-data-testing', {
            is: GetImperativeData
        });
        document.body.appendChild(element);

        // Get button element
        const buttonEl = element.shadowRoot.querySelector('lightning-button');

        // Set up error
        element.error = 'No Records Founds';

        // Simulate button click
        buttonEl.dispatchEvent(new CustomEvent('click'));

        // Return a promise to wait for any asynchronous DOM updates. Jest will automatically wait
        // for the Promise chain to complete before ending the test and fail the test if the promise
        // is rejected.
        return Promise.resolve().then(() => {
            const errorDiv = element.shadowRoot.querySelector('.errorDiv');
            expect(errorDiv.textContent).toBe('Error Message : No Records Founds');
        });
    });

});


/*
    import { createElement } from "lwc";
import GetImperativeData from 'c/getImperativeData'
//import fetchSomeContact from '@salesforce/apex/TestDataForLWC.fetchSomeContact';

const DATA = require('./data/data.json')
const ERROR = require('./data/error.json')
const EMPTY = require('./data/empty.json');

//jest.mock(moduleName, factory, options)
jest.mock('@salesforce/apex/TestDataForLWC.fetchSomeContact', 
    ()=>({
        default:jest:fn()
    }),
    {virtual:true}
)
describe('get-imperative-data-test test suite', ()=>{

    beforeEach(()=>{
        const element = createElement('get-imperative-data-test',{
            is: GetImperativeData
        })
        document.body.appendChild(element);
    })

    it('test with data', ()=>{
        fetchSomeContact.mockResolvedValue(DATA);
        const element = document.querySelector('get-imperative-data-test')
        const buttonElement = element.shadowRoot.querySelector('lightning-button')
        buttonElement.click()
        return new Promise(setImmediate).then(()=>{
            const dataElement = element.shadowRoot.querySelectorAll('.dataDiv');
            expect(dataElement.length).toBe(DATA.length);
        })
        

    })
})

*/
