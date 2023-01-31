import {createElement} from 'lwc'
import AccountContactCount from 'c/accountContactCount'
import { registerApexTestWireAdapter } from '@salesforce/sfdx-lwc-jest'
import fetchContactCount from '@salesforce/apex/AccountContactCountInLWCPage.fetchContactCount';

const mockData = require('./data/wireDataList.json')
const getAdapterList = registerApexTestWireAdapter(fetchContactCount)

const mockEmptyData = require('./data/wireEmptyData.json')

describe('c-account-contact-count test suite', ()=>{

    beforeEach(()=>{
        const element = createElement('c-account-contact-count', {
            is: AccountContactCount
        })
        document.body.appendChild(element);
    })

    it('test wire with data', ()=>{
        const element = document.querySelector('c-account-contact-count')
        getAdapterList.emit(mockData)
        return Promise.resolve().then(()=> {
            const tdElement = element.shadowRoot.querySelectorAll('td')
            expect(tdElement.length).toBe(mockData.length)
            expect(tdElement[0].textContent).toBe('Nezam Uddin')
        })
    })

    it('test wire with empty data', ()=>{
        const element = document.querySelector('c-account-contact-count')
        getAdapterList.emit(mockEmptyData)
        return Promise.resolve().then(()=> {
            const tdElement = element.shadowRoot.querySelectorAll('td')
            expect(tdElement.length).toBe(mockEmptyData.length)
            //expect(tdElement[0].textContent).toBe('Nezam Uddin')
        })
    })

    it('test wire with error', ()=>{
        const element = document.querySelector('c-account-contact-count')
        getAdapterList.error()
        return Promise.resolve().then(()=> {
            const errorElement = element.shadowRoot.querySelector('.error')
            expect(errorElement.textContent).not.toBeNull()
            //expect(tdElement[0].textContent).toBe('Nezam Uddin')
            

        })
    })


})
