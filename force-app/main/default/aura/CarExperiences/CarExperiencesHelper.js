({
	onInit : function(component,event,helper) {
        helper.callServer(component, "c.getCarExperiences",
                          function(response){
                              if(response){
                           		component.set("v.carExperiences", response);   
                              } else{
                                  console.log("error getting car experiences");
                              }
                          }, {
                              carId : component.get("v.car").Id
                          });
        /*var action = component.get("c.getCarExperiences");
        action.setParams({
            carId : component.get("v.car").Id
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") { 
                component.set("v.carExperiences", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);*/
    },
})