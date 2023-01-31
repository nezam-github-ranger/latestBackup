({
    putdatatype : function(component, actionName, val) {
        var action = component.get(actionName);
        action.setParams({ accName : val });
        action.setCallback(this, function(response) {
            console.log('Response ==> ', response.getReturnValue());
            component.set("v.acc", response.getReturnValue());
        });
        $A.enqueueAction(action);
    }   

});