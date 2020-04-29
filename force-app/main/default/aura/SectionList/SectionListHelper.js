({
	getCarType : function(component, helper) {
		helper.callServer(component, "c.getCarTypes", 
                          function(response){
                              component.set("v.carTypes", response);
                          });
	},
})