({
	doInit : function(component, event, helper) {
		component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'phone'},
            {label: 'Email', fieldName: 'Email', type: 'email'}
        ]);
        
        helper.getContacts(component, helper);
	},
    
    updateSelectedText: function (component, event) {
        var selectedRows = event.getParam('selectedRows');
        component.set('v.selectedRowsCount', selectedRows.length);
        component.set("v.selectedContacts", selectedRows);
    },
})