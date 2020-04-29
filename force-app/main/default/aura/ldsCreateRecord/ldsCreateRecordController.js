({
    doInit : function(component, event, helper) {
        component.find('recordCreator').getNewRecord(  
            'Beer__c',
            null,
            false,
            $A.getCallback(function(){
                var record = component.get('v.record');
                var error = component.get('v.recordError');
                if(error || (record === null)){
                    alert('Error while creating the template '+error);
                }else{
                   // alert('Successfully created the template ');
                }
            } 
                          )
        );
    },
    
    doSave: function(component, event, helper) {
        /* if we want to add some specific field value from backend like below */
        component.set('v.recordField.Alcohol__c','6.5');
        component.find('recordCreator').saveRecord(function(saveResult){
            if(saveResult.state ==='SUCCESS' ||saveResult.state ==='DRAFT' ){
                var showToast =$A.get('e.force:showToast')
                showToast.setParams({
                    "title":"Record saved Successfully" ,
                    "type":"success",
                    "message":"Beer roecord saved with record ID " +saveResult.Id 
                })
                showToast.fire();
            } else if(saveResult.state ==='INCOMPLETE'){
                alert();
                
            }else if(saveResult.state ==='ERROR'){
                alert();
            }
        });
        
    },
})