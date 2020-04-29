({
	doInit : function(component, event, helper) {        
        component.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
            {label: 'Owner', fieldName: 'Owner', type: 'text'},
            {label: 'Build Year', fieldName: 'Build_Year__c', type: 'number'},
            {label: 'Rent/Day', fieldName: 'Per_Day_Rent__c', type: 'currency', 
             typeAttributes: { currencyCode: 'USD'}},
            {label: 'Mileage', fieldName: 'Mileage__c', type: 'number'},
            {label: 'Available', fieldName: 'Available_For_Rent__c', type: 'boolean'},
            {label: 'View', type: 'button', initialWidth: 135, typeAttributes: 
             { label: 'View Details', name: 'view_details', title: 'Click to View Details'}}
        ]);
        
        helper.getCars(component, helper);
    },
    
    handleRowAction: function (component, event, helper) {
        var action = event.getParam('action');
        var car = event.getParam('row');
        switch (action.name) {
            case 'view_details':
                helper.showRowDetails(component, helper, car);
                break;
            default:
                helper.showRowDetails(component, helper, car);
                break;
        }
    },
})