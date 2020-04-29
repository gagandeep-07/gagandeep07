({
	handleClick : function(component, event, helper) {
		alert(component.getName());
		alert(component.isValid());
		alert(component.get('v.Whom'));
        //compoment.set takes 2 parameter 
        //key
        //value
        component.set('v.Whom',"bye bye");
        var inputField = component.find('inputText');
		alert(inputField.get('v.value'));
        inputField.set('v.value',"Jaddu");
        
    }
})