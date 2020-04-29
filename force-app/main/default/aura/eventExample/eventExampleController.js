({
    doChange : function(component, event, helper) {
        alert('value changed');
    },
    changehandler : function(component, event, helper) {
        // alert('helloooo' +component.get('v.test'));
        
        component.set('v.test','testing');
        // alert('helloooo' +component.get('v.test'));
    },
    doInit : function(component, event, helper) {
        component.set('v.test','On Init');
    }
})