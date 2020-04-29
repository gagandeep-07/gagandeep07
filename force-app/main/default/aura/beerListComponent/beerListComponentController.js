({
    myAction : function(component, event, helper) {
        //Default method with no Body
    },
    viewInfo : function(component, event, helper) {
        // event.getSource give you the event trigger Component i.e. Button
        var eventSource = event.getSource();
        var beerObj = eventSource.get('v.name');
        var beerName = eventSource.get('v.value');
        //beerIdClick attribute is not used anywhere
        //component.set("v.beerIdClick",evtSource.get('v.name'));
        //Creating the dynamic Lightning CMP and Open that in a Modal
        $A.createComponent(
            "c:beerDetails",
            {
                "beerId" : beerObj,
                "beerName" : beerName
            },
            function(beerDtails,status,errorMessage){
                if(status === "SUCCESS"){
                    component.find('overlayLib').showCustomModal({
                        header: "Beer Dtails",
                        body: beerDtails,
                        footer:'this footer is test',
                        showCloseButton: true,
                        closeCallback: function() {
                            console.log('Modal is closes');
                        }
                    });
                }
                else{
                    console.log('Error aagya hai Please Check hthe code'+status );
                }
            }
        );
        
    },
    addToCart : function(component, event, helper) {
        console.log('add to cart');
        var eventSource = event.getSource();
        var beerId = eventSource.get('v.name');
        var index = eventSource.get('v.value');
        console.log('beer index'+index);
        var selectedBeer = component.get('v.beerList')[index];
        console.log(' selectedBeer '+ selectedBeer.Id);
        console.log(selectedBeer.Id);
        var addToCartEvent = component.getEvent('addToCart');
        addToCartEvent.setParams({
            beerRecord : selectedBeer
        });
        addToCartEvent.fire();
    },
    
})