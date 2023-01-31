({
   myAction : function(component, event, helper) {
        var action = component.get("c.getAllAccounts");
        action.setCallback(this, function(response){
            if (response.getState() === "SUCCESS") {
                console.log('response => ' + response.getReturnValue());
                component.set("v.acc", response.getReturnValue());
            }
        });
     $A.enqueueAction(action);
    },
    handleSearch : function(component, event, helper) {
        helper.putdatatype(component, "c.getSearchedAccount", component.get("v.accountName"));
        //component.set("v.acc", response.getReturnValue());
    }
})