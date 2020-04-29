({
    handleKeyUp: function (component, evt) {
        var isEnterKey = evt.keyCode === 13;
        //if (isEnterKey) {
            var queryTerm = component.find('enter-search').get('v.value');
            alert('Searched for "' + queryTerm + '"!');
       // }
        //step 1
        var action = component.get('c.getDetails');
        //Mack the Action as storable 
        //action.setStorable();
        
        var accountId = component.get('v.recordId');
        //step 2
        action.setParams({
            channelId : queryTerm
        });
        //step 4
        action.setCallback(this,function(response){
            if(response.getState() == 'SUCCESS'){
                // alert('State is SUCCESS');
                var responseValue = response.getReturnValue();
                alert('responseValue--> '+JSON.stringify(responseValue));
                component.set('v.response' , responseValue);
            }
            else{
                alert('State is Error'+response.getError());
                console.log(response.getError());
            }
            
        });
        //step 3
        $A.enqueueAction(action); // it sends the request to the server
    }
});