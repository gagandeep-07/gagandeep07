({
    doFormSubmit : function(component, event, helper) {
        //fetching carTypeId attribute value from event
        var carTypeId1 = event.getParam('carTypeId');
        console.log('selected car type id '+carTypeId1);
        
        
        var carSearchResultComp = component.find("carSearchResult");
        
        // call the aura:method in the child component
        var carSearchCmpResult = carSearchResultComp.searchCars(carTypeId1);
        console.log("auraMethodResult: " + carSearchCmpResult);
    },
    
    showHome : function(component, event, helper) {
        component.find("sectionList").changeSelection("home");
    },
    
    changeComponent: function(component, event, helper) {
        var componentName = event.getParam("componentName");
        if(componentName){
            if(componentName === "home"){
                if(!component.get("v.showHome")){
                    component.set("v.showHome", true);
                    component.set("v.showCarList", false);
                    component.set("v.showOwnerList", false);
                    component.set("v.showFilteredCars", false);
                }
            } else if(componentName === "car"){
                if(!component.get("v.showCarList")){
                    component.set("v.showCarList", true);
                    component.set("v.showFilteredCars", false);
                    component.set("v.showOwnerList", false);
                    component.set("v.showHome", false);
                }
            } else if(componentName === "owner"){
                if(!component.get("v.showOwnerList")){
                    component.set("v.showOwnerList", true);
                    component.set("v.showCarList", false);
                    component.set("v.showHome", false);
                    component.set("v.showFilteredCars", false);
                }
            } else {
                if(!component.get("v.showFilteredCars")){
                    component.set("v.showFilteredCars", true);
                    component.set("v.showCarList", false);
                    component.set("v.showOwnerList", false);
                    component.set("v.showHome", false);
                }
                
                var carSearchResultComponent = component.find("carSearchResultNavigation");
                carSearchResultComponent.searchCars(componentName);
            }
        }
    },
    
    hideDetails : function(component, event, helper) {
        component.set("v.showDetails", false);
    },
    
    showDetails : function(component, event, helper) {
        component.set("v.showDetails", true);
    },
})