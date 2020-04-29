({
    handleShowModal : function(component, event, helper) {
        // Modal has header , close button , footer and body 
        component.find('overlayLib').showCustomModal({
            header: "Application Confirmation",
            body: 'this header is test',
            footer:'this footer is test',
            showCloseButton: true,
            closeCallback: function() {
                alert('You closed the alert!');
            }
        });
    },
    
    handleNavigate: function(component, event, helper) {
        //getting the Navigation aura:id
        var navServiceVar = component.find('navService');
        //creating the Page referance object, where we want to redirect , URL, Custom Component, Object Page
        var pageReference = {
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'list'
            }, 
            state: {
                //State parameter are the parameter that need to Pass in URL
                //parameter you want to send on URL https://sfcodezone-dev-ed.lightning.force.com/lightning/o/Account/list?filterName=MyAccounts
                filterName: "MyAccounts"
            }
        };
        //here we navigate to the Page Reference
        navServiceVar.navigate(pageReference);
    },
    navigateBeerBar :function(component, event, helper) {
        //getting the Navigation aura:id
        var navServiceVar = component.find('navService');
        //creating the Page referance object, where we want to redirect , URL, Custom Component, Object Page
        //if you redirect to any custom lightning cmp , That components must implements the interface lightning:isUrlAddressable.
        var pageReference =  {    
            "type": "standard__component",
            "attributes": {
                "componentName": "c__beerExplorer"    
            },    
            "state": {
                "myAttr": "attrValue"    
            }
        };
        navServiceVar.navigate(pageReference);
    },
    dynamicComp:function(component, event, helper) {
        $A.createComponent("lightning:button",{
            "label":"press me",
            "onClick":component.getReference("c.handleSubmit")
        },
                           function(newButton,status,errorMessage){
                               if(status === "SUCCESS"){
                                   alert(status);
                                   var body = component.get("v.body");
                                   body.push(newButton);
                                   component.set("v.body",body);
                               }
                               else{
                                   alert('Error aagya hai'+status );
                               }
                           }
                          );
    },
    handleLoad:function(component, event, helper) {
        
    },
    handleSubmit:function(component, event, helper) {
        alert('Submit handled');
    },
    handleSuccess:function(component, event, helper) {
        
    },
})