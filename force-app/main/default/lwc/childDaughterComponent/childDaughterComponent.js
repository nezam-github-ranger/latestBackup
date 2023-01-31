import { LightningElement, api } from 'lwc';

export default class ChildDaughterComponent extends LightningElement {

    @api msg = 'msggg';

    handleClick(event) {
        const selectedEvent = new CustomEvent("message", {
            detail: 'Miss You Bhaiii'
        });
      
          // Dispatches the event.
          this.dispatchEvent(selectedEvent);
    
    }

}