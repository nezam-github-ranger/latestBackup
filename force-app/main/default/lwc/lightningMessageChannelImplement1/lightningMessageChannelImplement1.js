import { LightningElement, track } from 'lwc';
import { publish,subscribe,unsubscribe,createMessageContext,releaseMessageContext } from 'lightning/messageService';
import SAMPLEMC from "@salesforce/messageChannel/MyMessageChannel__c";


export default class LightningMessageChannelImplement1 extends LightningElement {

    @track receivedMessage = '';
    @track myMessage = '';
    subscription = null;
    context = createMessageContext();

    constructor() {
        super();
        this.subscribeMC(); //subscribe on load
        console.log('receivedMessage ==> ', this.receivedMessage);

    }

    handleChange(event) {
        this.myMessage = event.target.value;
    }

    publishMC() {
        console.log('this.myMessage ==> ', this.myMessage);
        const message = {
            messageToSend: this.myMessage,
            sourceSystem: "From LWC"
        };
        publish(this.context, SAMPLEMC, message);
    }

    subscribeMC() {
        console.log('subscribeMC Method');
        if (this.subscription) {
            return;
        }
        this.subscription = subscribe(this.context, SAMPLEMC, (message) => {
            this.displayMessage(message);
        });
    }
 
    unsubscribeMC() {
        console.log('unsubscribeMC Method');
        unsubscribe(this.subscription);
        this.subscription = null;
    }

    displayMessage(message) {
        console.log('message ==> ', message);
        if(message.sourceSystem === 'From VisualForce Page'){
            this.receivedMessage = message.messageToSend;  
        }
        console.log('receivedMessage ==> ', this.receivedMessage);
        //this.receivedMessage = message ? JSON.stringify(message, null, '\t') : 'no message payload';
    }

    disconnectedCallback() {
        console.log('disconnectedCallback Method');
        releaseMessageContext(this.context);
    }

}