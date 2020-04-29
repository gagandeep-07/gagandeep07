({
	doFormSubmit : function(component, event, helper) {
        //fetching carTypeId attribute value from event
        var carTypeId = event.getParam('carTypeId');
        helper.carSearchResult(component, helper, carTypeId);
	},
})