({
    
    getContactList: function(component, event, helper) {
        var action = component.get('c.getContact');
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.listContact', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
        //$A.get('e.force:refreshView').fire();
    }
    
    
    
})