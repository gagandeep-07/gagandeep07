({
	doInit : function(component, event, helper) {
		helper.onInit(component, event, helper);
	},
    
    /*
     * This function is called when the experience is saved
     * */
    onSave: function(component, event, helper) {
        component.set("v.carExperience.Car__c", component.get("v.car.Id"));
        component.find("service").saveRecord($A.getCallback(function(saveResult) {
            // NOTE: If you want a specific behavior(an action or UI behavior) when this action is successful 
            // then handle that in a callback (generic logic when record is changed should be handled in recordUpdated event handler)
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                
                var resultsToast = $A.get("e.force:showToast");
                if(resultsToast)
                {
                    resultsToast.setParams({
                        "title": "Saved",
                        "type" : "success",
                        "message": "Car Experience Added"
                    });
                    resultsToast.fire(); 
                }
                else
                {
                    alert('Car Experience Added');
                }
                
                helper.onInit(component, event, helper);
                
                var evt = component.getEvent("carExpAdded");
                evt.fire();
                
            } else if (saveResult.state === "INCOMPLETE") {
                helper.showToast(component, event, helper, {
                    "title": "ERROR!",
                    "type": "error",
                    "message": "Device does not support draft"
                });
                console.log("User is offline, device doesn't support drafts.");
            } else if (saveResult.state === "ERROR") {
                helper.showToast(component, event, helper, {
                    "title": "ERROR!",
                    "type": "error",
                    "message": "Problem saving record"
                });
                console.log('Problem saving record, error: ' + JSON.stringify(saveResult.error));
            } else {
                helper.showToast(component, event, helper, {
                    "title": "ERROR!",
                    "type": "error",
                    "message": "Unknown problem"
                });
                console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
            }
        }));
    },

    /**
     * Control the component behavior here when record is changed (via any component)
     */
    onRecordUpdated: function(component, event, helper) {
        var eventParams = event.getParams();
        if(eventParams.changeType === "CHANGED") {
            // get the fields that changed for this record
            var changedFields = eventParams.changedFields;
            console.log('Fields that are changed: ' + JSON.stringify(changedFields));
            // record is changed, so refresh the component (or other component logic)
            helper.showToast(component, event, helper,{
                "title": "Saved",
                "type": "error",
                "message": "The record was updated."
            });

        } else if(eventParams.changeType === "LOADED") {
            // record is loaded in the cache
        } else if(eventParams.changeType === "REMOVED") {
            // record is deleted and removed from the cache
        } else if(eventParams.changeType === "ERROR") {
            // there’s an error while loading, saving or deleting the record
        }
    }
    
})