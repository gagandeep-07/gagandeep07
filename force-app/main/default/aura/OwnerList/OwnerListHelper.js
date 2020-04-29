({
	getContacts : function(component, helper) {
		helper.callServer(component, "c.getContacts", 
                          function(response){
                              component.set("v.data", response);
                          })
	}
})