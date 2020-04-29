({
	getCars : function(component, helper) {
        helper.callServer(component, "c.getAllCars", 
                          function(response){
                              for(var i=0; i<response.length; i++){
                                  var row = response[i];
                                  row.Owner = row.Contact__r.Name;
                              }
                              component.set("v.data", response);
                          });
    },
    
    showRowDetails : function(component, helper, car) {
        /*
         * Now firing application event to 
         * notify other components when a car is selected. 
         * Other components can get the car attribute value
         * and can handle the event accordingly
         * */
        var appEvent = $A.get("e.c:CarSelectedApplicationEvent");
        if(appEvent){
            appEvent.setParams({
                "car" : car,
            });
            appEvent.fire();
        } else{
            //alert("Event not supported");
        }
    },
})