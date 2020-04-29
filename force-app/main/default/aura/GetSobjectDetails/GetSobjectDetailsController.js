({    
    doinit : function(component, event, helper) {
        var action = component.get('c.getAllSobjects'); 
        // method name i.e. getAllSobjects should be same as defined in apex class
        // params name i.e. entityType should be same as defined in getEntity method
        /* action.setParams({
            "entityType" : component.get('v.componentString') 
        });*/
        action.setCallback(this, function(a){
            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                var sObjectList =a.getReturnValue();
                var newlst =[];
                for(var i in sObjectList){
                    var serverResponse = {
                        id: sObjectList[i], label: sObjectList[i], selected: false
                    };
                    newlst.push(serverResponse);
                }
                console.log('List of Sobjects--- '+JSON.stringify(newlst));
                component.set('v.options',newlst);
            }
        });
        $A.enqueueAction(action);
    },
    onChange : function(component, event, helper) {
        var action = component.get('c.getAllObjectFields'); 
        // method name i.e. getAllSobjects should be same as defined in apex class
        // params name i.e. entityType should be same as defined in getEntity method
        action.setParams({
            "sObjectName" : component.find('colorId').get('v.value')
        });
        action.setCallback(this, function(a){
            var state = a.getState(); // get the response state
            if(state == 'SUCCESS') {
                var sObjectList =a.getReturnValue();
                var newlst =[];
                for(var i in sObjectList){
                    var serverResponse = {
                        id: sObjectList[i], label: sObjectList[i], selected: false
                    };
                    newlst.push(serverResponse);
                }
                console.log('List of Sobjects--- '+JSON.stringify(newlst));
                component.set('v.fieldNames',newlst);
            }
        });
        $A.enqueueAction(action);        
    },
    onSelect: function(component, event, helper) {
        var evtSource = event.getSource();
        //alert(evtSource.get('v.name'));
        var stringQuery = component.get('v.query');
        stringQuery +=' '+evtSource.get('v.name');
        component.set('v.query',stringQuery);
        // component.set("v.beerIdClick",evtSource.get('v.name'));
    },
})