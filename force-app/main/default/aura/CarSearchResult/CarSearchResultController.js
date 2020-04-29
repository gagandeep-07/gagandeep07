({
    doInit : function(component, event, helper) {
        helper.onSearch(component, helper);
    },
    
    doSearch : function(component, event, helper) {
        //this line will get all the argument passed to aura:method
        var params = event.getParam('arguments');
        
        //checking if param is not undefined
        if (params) {
            //getting carTypeId from argumentlist, and setting component attribute value
            component.set("v.carTypeIdComponent", params.carTypeId);
            helper.onSearch(component, helper);
        }
    },
    
    onCarSelect : function(component, event, helper) {
        // use event.getParam to get attribute value from event
        component.set("v.selectedCarId", event.getParam("carId"));
    },
})