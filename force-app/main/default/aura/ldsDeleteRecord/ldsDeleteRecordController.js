({
    
    doDelete: function(component, event, helper) {
        /* if we want to add some specific field value from backend like below */
        //component.set('v.recordField.Alcohol__c','6.5');
        component.find('recordDelete').deleteRecord($A.getCallback(function(deleteResult){
            if(deleteResult.state ==='SUCCESS' ||deleteResult.state ==='DRAFT' ){
                var showToast =$A.get('e.force:showToast')
                showToast.setParams({
                    "title":"Record deleted Successfully",
                    "type":"success",
                    "message":"Beer record has been deleted" 
                })
                showToast.fire();
                var pageReference = component.find('navService');
                pageReferenceNave = {
                    type: 'standard__objectPage',
                    attributes: {
                        objectApiName: 'Beer__c',
                        actionName: 'list'
                    },
                    state: {
                        
                    }
                };
                pageReference.navigate(pageReferenceNave);
                
            } else if(deleteResult.state ==='INCOMPLETE'){
                alert('Incomplete Delete');
                
            }else if(deleteResult.state ==='ERROR'){
                alert('Error Occurred');
            }
        }));
    },
})