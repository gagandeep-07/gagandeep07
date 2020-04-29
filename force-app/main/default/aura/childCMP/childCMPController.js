({
    childAction : function(component, event, helper) {
        //Getting the attributes which are passed from Parent Components
        var params = event.getParam('arguments');
        if(params){
            var paramChild = params.param;
        }		
        alert('child component param '+ paramChild);
    },
    onClick : function(component, event, helper) {
        alert('Child method called');
    },
})