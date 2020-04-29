({
    doSearchEvent : function(component, event, helper) {
        var searchParam = event.getParam('searchText');
        //  alert(searchParam);
        var action = component.get('c.getBeerList');
        action.setParams({
            searchParam : searchParam  
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state === 'SUCCESS'){
                //alert(JSON.stringify(response.getReturnValue()));
                component.set('v.beerList',response.getReturnValue());
            }
            else{
                Console.log(response.getError());
            }
        });
        $A.enqueueAction(action);
    },
	updateCart : function(component, event, helper){
        var params = event.getParam('beerRecord');
        //component.set('v.beerRecord', beerRecord);
        var headerComp = component.find('headerComp');
        headerComp.updateCart(params);
    },    
    
})