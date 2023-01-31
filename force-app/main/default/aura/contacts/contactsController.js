({
    goToRecord : function(component, event, helper) {
        alert('goto record call in contacts');
        var parentComponent = component.get("v.parent");   
        console.log('parent component ==> ', parentComponent);
		parentComponent.greetingMethod();
   }
	
})