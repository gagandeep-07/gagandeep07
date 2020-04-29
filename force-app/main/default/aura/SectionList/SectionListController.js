({
    
    doInit : function(component, event, helper) {
        helper.getCarType(component, helper);
	},
    
	changeComponent : function(component, event, helper) {
        var navigationItem = event.getParam("name");
        var chngCmp = component.getEvent("changeComponent");
        if(chngCmp){
            chngCmp.setParams({
                "componentName" : navigationItem
            });
            chngCmp.fire();
        }
        
        /*
         * This application event is fired
         * to hide cardetails and map component
         * */
        var hideCarDetailsAppEvent = $A.get("e.c:HideSideBar");
        if(hideCarDetailsAppEvent){
            hideCarDetailsAppEvent.fire();
        } else{
            alert("Event not supported");
        }
	},
    
    changeSelection : function(component, event, helper) {
        var navigationItemName = event.getParam("arguments").componentName;
        component.find("quickView").set("v.selectedItem", navigationItemName);
	},
})