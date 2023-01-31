import { LightningElement, wire, track} from 'lwc';
import fetchContactCount from '@salesforce/apex/AccountContactCountInLWCPage.fetchContactCount';

export default class AccountContactCount extends LightningElement {
		
	@wire (fetchContactCount)
	accounts
	isChecked = false;

	renderedCallback(){
		console.log('accounts ==> ', this.accounts);	
	}
	
	checkboxHandler(){
		this.isChecked = !this.isChecked;	
	}
}