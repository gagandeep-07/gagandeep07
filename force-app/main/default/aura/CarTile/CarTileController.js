({
	onCarClick : function(component, event, helper) {	
        var car = component.get("v.car");
        
        /*
         * Create CarSelect event and pass required carId field
         * fire the event so that parent CarSearchResult component
         * can handle the event
         * */
        var evt = component.getEvent("onCarSelect");
        evt.setParams({
            "carId" : car.Id
        });
        evt.fire();
        
        
        /*
         * Now firing application event to 
         * notify other components when a car is selected. 
         * Other components can get the car attribute value
         * and can handle the event accordingly
         * */
        var appEvent = $A.get("e.c:CarSelectedApplicationEvent");
        debugger;
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