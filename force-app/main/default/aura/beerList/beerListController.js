({
    myAction : function(component, event, helper) {
        
    },
    viewInfo : function(component, event, helper) {
        var evtSource = event.getSource();
        //alert(evtSource.get('v.name'));
        component.set("v.beerIdClick",evtSource.get('v.name'));
        $A.createComponent(
            "c:beerDetails",
            {
                "beerID":evtSource.get('v.name'),
            },
            function(beerDtails,status,errorMessage){
                if(status === "SUCCESS"){
                    component.find('overlayLib').showCustomModal({
                        header: "Beer Dtails",
                        body: beerDtails,
                        footer:'this footer is test',
                        showCloseButton: true,
                        closeCallback: function() {
                            //alert('You closed the alert!');
                        }
                    });
                    
                }
                else{
                    alert('Error aagya hai'+status );
                }
            }
        );
        
    },
    
})