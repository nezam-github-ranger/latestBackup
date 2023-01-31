({
    doInit : function(component, event, helper) {
        // Retrieve contacts during component initialization
        helper.loadContacts(component);
    },
    
    handleSelect : function(component, event, helper) {
        var contacts = component.get("v.contacts");
        var contactList = component.get("v.contactList");
        
        //Get the selected option: "Referral", "Social Media", or "All"
        var selected = event.getSource().get("v.value");
        
        var filter = [];
        var k = 0;
        for (var i=0; i < contactList.length; i++){
            var c = contactList[i];
            if (selected != "All"){
                if(c.LeadSource == selected) {
                    filter[k] = c;
                    k++; 
                }
            }
            else {
                filter = contactList;
            }       
        }
        //Set the filtered list of contacts based on the selected option
        var toastEvent = $A.get("e.force:showToast");
        if(filter.length < 1){
            toastEvent.setParams({
                "title": "Error!",
                "type" : "warning",
                "message": " No records found."
            });
        }
        toastEvent.fire();		    
        component.set("v.contacts", filter);
        helper.updateTotal(component);
    },
    goToRecord : function(component, event, helper) {
        alert('goto record call in parent');
        component.set("v.showModal", true);
   }
})