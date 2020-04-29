({
    handleClick : function(component, event, helper) {
		alert(component.getName());
		alert(component.isValid());
		alert(component.get('v.Whom'));
        //compoment.set takes 2 parameter 
        //key
        //value
        component.set('v.Whom',"bye bye");
        //getting the value with Aura:id
        var inputField = component.find('inputText');
        alert(inputField.get('v.value'));
        //Setting the value with Aura:id
        inputField.set('v.value',"Jaddu");
        
    },
    doCreatMap : function(component, event, helper) {
            var map = [];
            // Key and Value
            for(var i=0; i < 10; i++){
                map.push({
                    key:i, 
                    value:'Test '+i
                });
            }
            component.set('v.mapVar', map);
        }
})