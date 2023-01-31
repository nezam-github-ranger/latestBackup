({
    
    doInit : function(component, event, helper) {
    	helper.getContactList(component);
    	
	},
    
    doSave : function(component, event, helper) {
     
        var action = component.get("c.saveContact");
        action.setParams({"contactObj": component.get("v.contactMap")});
        $A.get('e.force:refreshView').fire();
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "Contact record has been inserted successfully."
                });
                toastEvent.fire();
            }
            else if (state === "INCOMPLETE") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "OFFLINE!",
                    "message": "You are in offline."
                });
                toastEvent.fire();
            }
            else if (state === "ERROR") {
                    var errors = response.getError();
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "ERROR!",
                        "message": errors[0].message
                    });
                    toastEvent.fire();
           	}
           	else{
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "UNKOWN!",
                    "message": "Unknown error."
                });
                toastEvent.fire();
            }
        });
        
        $A.enqueueAction(action);
        $A.get('e.force:refreshView').fire();
        helper.getContactList(component);
        
    }, 
    
    handleDelete: function(component, event, helper){
        var eventSource = event.getSource();
       	var Id = eventSource.get('v.name');
        
        var action = component.get("c.deleteContact");
        action.setParams({"deletedId": Id});
        
        helper.getContactList(component);
        $A.enqueueAction(action);
        $A.get('e.force:refreshView').fire();
        
    }, 
    
    handleEdit: function(component, event, helper){
    	var eventSource = event.getSource();
    	var Id = eventSource.get('v.name');
    	//alert('Current Edit Id ==> ' + Id);
        
        var action = component.get("c.editContact");
        action.setParams({"editedId": Id});
        
       	action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS"){
                //alert('success');
                console.log("From server: ",JSON.stringify(response.getReturnValue()));
                console.log('Contact Map :',JSON.stringify(component.get("v.contactMap")));
                component.set("v.contactMap", { 'Id': response.getReturnValue().Id, 'FirstName': response.getReturnValue().FirstName, 'LastName' : response.getReturnValue().LastName,
                                                 'Email' : response.getReturnValue().Email, 'Phone' : response.getReturnValue().Phone });
           
            }
            else if (state === "INCOMPLETE") {
               alert('INCOMPLETE');
            }
            else if (state === "ERROR") {
                  alert('ERROR');
           	}
           
        });
        
        //helper.getContactList(component);
    	$A.enqueueAction(action);
        //$A.get('e.force:refreshView').fire();
	}
    
})