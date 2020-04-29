({
	onSearch : function(component, helper) {
		helper.callServer(component, "c.getCars", 
                          function(response){
                              debugger;
                              if(response.length >0 ){
								component.set("v.cars", response);
                                component.set("v.carFound", true); 
                              } else{
                                  component.set("v.carFound", false);
                              }
                          },{
                              carTypeId : component.get("v.carTypeIdComponent")
                          });
        
        /*
         * Below code is used to call server side controller without inheritance
         * however above code is perfect example to use inheritance
         * and is working the same way as below function */
        /*var action = component.get("c.getCars");
        action.setParams(
            { 
                carTypeId : component.get("v.carTypeId")
            }
        );
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.cars", response.getReturnValue());
                component.set("v.carFound", true); 
            }
        });
         $A.enqueueAction(action); */
	},
})