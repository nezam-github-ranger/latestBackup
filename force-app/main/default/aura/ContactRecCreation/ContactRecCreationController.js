({
	doSave : function(component, event, helper) {
        alert('do save alert');
		var action = component.get("c.createContactDemo");
        action.setParams({'contObj':component.get('v.contactObj')});
        action.setCallback(this, function(data){
        	component.set('v.contactId',data.getReturnValue());                  
		});
        $A.enqueueAction(action);
	},
    showContacts : function(component, event, helper){
        alert('init');
        //console.log('init');
        var action = component.get("c.retrieveContacts");
        action.setCallback(this, function(data){
            component.set('v.contactList', data.getReturnValue());
        })
        $A.enqueueAction(action);
    },
})