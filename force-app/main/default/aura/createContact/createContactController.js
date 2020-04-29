({
    doSave : function(component, event, helper) {
        var con = component.get('v.createContact');
        
        //We can validate the Field value by cheking the Field values
        /* if(con.FirstName == ''|| con.FirstName == Null || con.FirstName == Undefined){
            alert('Please Enter the first Name');
        }*/
        //But below above is not fisible if you have to Validate 20-30 field on the form
        
        //Validate the many field by reduce Method
        var validContact = component.find('contactForm').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            inputCmp.set('v.validity', {valid:false, badInput :true});
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        alert(validContact);
        if(validContact){
            var accountId = component.get('v.acctId');
            var action = component.get('c.createContact');
            action.setParams({
                Con : con,
                accId : accountId
            });
            action.setCallback(this,function(response){
                //alert('callback method');
                alert('Contact Created'+response.getReturnValue());
                var state = response.getState();
                if(response.getState() === 'SUCCESS'){
                    var insertedCon = response.getReturnValue();
                    //  if(insertedCon.lenght > 0){
                    //  alert('Contact Created'+insertedCon );
                    //  First Get the event that we register in Child CMP
                    var cmpEvt = component.getEvent('quickContact');
                    //Set the Param that we are passing to the Event's Attribute with same attribute name
                    cmpEvt.setParams({
                        contactRecord : insertedCon
                    });
                    //Fire the event
                    cmpEvt.fire();
                    //  }
                }else if(state === 'INCOMPLETE'){
                    console.log('Server call is incomplete Please check the Backend Controller');
                }else if(state === 'ERROR'){
                    var errors = response.getError(); //Array of Error
                    console.log('Error ', errors[0].duplicateResults);
                    console.log('Error ', errors[0].fieldErrors);
                    console.log('Error ', errors[0].pageErrors[0].message);
                    component.set('v.ErroMessage' , errors[0].pageErrors[0].message);
                    if(errors || errors[0].message){
                        component.set('v.ErroMessage' , errors[0].pageErrors[0].message);
                        console.log('Error is - '+errors[0].message);
                    }
                }
                    else{
                        alert('error occurred'+response.getError());
                        console.log('errors ----'+JSON.stringify(response.getError()));  //Array of ERRORS
                    }
            });
            $A.enqueueAction(action);
        }else{
            console.log('Please Input all the inputs');
        }
    },
})