({
    
    getCarType : function(component, helper) {
        
        /*
         * Below line of code does not make use of 
         * inheritance and can be run without extending
         * base component
         * 'v' - View or value provider
         * 'c' (in component markup) - Client Side Controller
         * 'c' (in client side controller/helper) - Server Side Controller
         * */
        /*var action = component.get("c.getCarTypes");
        action.setCallback(this, function(data) {
            var state = data.getState();
            if (state === "SUCCESS") { 
            	component.set("v.carTypes", data.getReturnValue());
            } else if (state === "ERROR") {
            	alert('Unknown Error');
            }
        });
        $A.enqueueAction(action);*/
        
        
        helper.callServer(component, "c.getCarTypes", 
                          function(response){
                              component.set("v.carTypes", response);
                          });
    }
})