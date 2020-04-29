({
    doChildClick : function(component, event, helper) {
        var child =component.find('childcmp');
        //Calling the Child Component Aura:merthod from the Parent Component
        child.childAct('im from parent cmp to child cmp');
    },
    handleChildAction : function(component, event, helper) {
        alert('i m from Child CMP to Parent CMP');
    },
})