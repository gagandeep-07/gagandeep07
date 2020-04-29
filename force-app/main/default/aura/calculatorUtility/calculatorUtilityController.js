({
    doadd : function(component, event, helper) {
        var num1 = component.get('v.number1');
        var num2 = component.get('v.number2');
        component.set('v.output',parseInt(num1)+parseInt(num2));
        
    },
    dosub : function(component, event, helper) {
        var num1 = component.get('v.number1');
        var num2 = component.get('v.number2');
        component.set('v.output',parseInt(num1)-parseInt(num2));
    },
    domul : function(component, event, helper) {
        var num1 = component.get('v.number1');
        var num2 = component.get('v.number2');
         component.set('v.output',parseInt(num1)*parseInt(num2));   
    },
    dodiv : function(component, event, helper) {
        var num1 = component.get('v.number1');
        var num2 = component.get('v.number2');
        component.set('v.output',parseInt(num1)/parseInt(num2));
    }
})