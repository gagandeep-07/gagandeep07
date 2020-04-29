({
    doInit : function(component, event, helper) {
        //will be fetching car type from backend using apex controller
        var createCarRecord = $A.get("e.force:createRecord");
        if(createCarRecord){
            component.set("v.showNew", true);
        } else{
            component.set("v.showNew", false);
            console.log('event is not supported');
        }
        
        helper.getCarType(component, helper);
    },
    
    onSearchClick : function(component, event, helper) {
        var searchFormSubmit = component.getEvent("searchFormSubmit");
        searchFormSubmit.setParams({
            //get selected carTypeId from picklist 
            //and pass in event attribute
            "carTypeId" : component.find("carTypeList").get("v.value")
        });
        searchFormSubmit.fire();
	},
    
    createRecord : function(component, event, helper) {
		var createCarRecord = $A.get("e.force:createRecord");
        

        createCarRecord.setParams({
            "entityApiName": "Car_Type__c"
        });
        //This line fires system event
        createCarRecord.fire();
	}, 
    
    /*
     * reference code
         var carTypeId = component.find("carType").get("v.value");
         var createBoatRecord = $A.get("e.force:createRecord");
     */
})