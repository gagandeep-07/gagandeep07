({
    doinit : function(component, event, helper) {
        //step 1
        var action = component.get('c.getContactList');
        //Mack the Action as storable 
        action.setStorable();
        
        var accountId = component.get('v.recordId');
        //step 2
        action.setParams({
            accId : accountId
        });
        //step 4
        action.setCallback(this,function(response){
            
            if(response.getState() == 'SUCCESS'){
                // alert('State is SUCCESS');
                var responseValue = response.getReturnValue();
                console.log('responseValue--> '+JSON.stringify(responseValue));
                component.set('v.ContLst' , responseValue);
            }
            else{
                alert('State is Error'+response.getError());
            }
            
        });
        //step 3
        $A.enqueueAction(action); // it sends the request to the server
    },
    
    viewContact : function(component, event, helper) {
        alert('View contact');     
        var event = event.getSource();
        var id = event.get('v.name');
        alert(id);
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": id,
            "slideDevName": "detail"
        });
        navEvt.fire();
    },
    eventHandler: function(component, event, helper) {
        alert('event handled ');
        //Below event reload the Data for the view
        $A.get('e.force:refreshView').fire();
        var availableContact = component.get('v.ContLst');
         //Getting the event attribute value from Event
        var recordCon = event.getParam('contactRecord');
        availableContact.push(recordCon);
        component.set('v.ContLst',availableContact);
    },
    
})