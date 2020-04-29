({
    displaySection1 : function(component, event, helper) {
        component.set("v.displayedSection","section1");
        var section1InputValue = component.find("sec1value");
        console.log('***section1InputValue: '+section1InputValue);
        var section2InputValue = component.find("sec2value");
        console.log('***section2InputValue: '+section2InputValue);
    },
    displaySection2 : function(component, event, helper) {
        component.set("v.displayedSection","section2");
        var section1InputValue = component.find("sec1value");
        console.log('***section1InputValue: '+section1InputValue);
        var section2InputValue = component.find("sec2value");
        console.log('***section2InputValue: '+section2InputValue);
    },
    doInit : function(component, event, helper) {
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        alert(userId);
    },
    
})