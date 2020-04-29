({
    handleClick : function(component, event, helper) {
       /* alert('hii '+component.isValid());	
        alert('hii '+component.getName());		
        alert('hii '+component.getType());		
        */
         alert('hii '+component.get('v.whom'));	
        //2 parameters
        //key - attribute 
    component.set('v.whom',"Test Zone");
        var search = component.find('entersearch');
        alert('search Aura id '+search + search.get('v.value'));
        search.set('v.value',"Testing the Aura id")
        
    },
    check: function(component, event, helper) {
                var identityRequest = component.find("input2").get("v.value");
alert(identityRequest);
    
    }
})