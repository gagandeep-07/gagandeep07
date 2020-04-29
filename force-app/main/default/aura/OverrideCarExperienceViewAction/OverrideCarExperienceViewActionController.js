({
	onEdit: function(component,event,helper) {
        var e = $A.get("e.force:editRecord");
        e.setParams({
             "recordId": component.get('v.recordId')
        });
        e.fire();
    },
})