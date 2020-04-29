({
	carSearchResult : function(component, helper, carTypeId) {
		
        var carSearchResultComp = component.find("carSearchResult");
        
        // call the aura:method in the child component
        var carSearchCmpResult = carSearchResultComp.searchCars(carTypeId);
	},
})