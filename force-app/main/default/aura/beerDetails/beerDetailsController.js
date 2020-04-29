({
    doOrderBeer : function(component, event, helper) {
        var navServiceVar = component.find("navService");
        //Navigating to beerOrder Component to Order the beer
        //parameter you want to send on URL https://sfcodezone-dev-ed.lightning.force.com/lightning/o/Account/list?filterName=MyAccounts
        
        var pageReference = {
            "type": "standard__component",
            "attributes": {
                "componentName": "c__beerOrder"
            }, 
            "state": {
                "c__beerId": component.get('v.beerId'),
                "c__beerName" : component.get('v.beerName')
            }
        };
        navServiceVar.navigate(pageReference); 
        //https://sfcodezone-dev-ed.my.salesforce.com/c__beerOrder?beerId=a010o00001weP3jAAE
        //https://sfcodezone-dev-ed.lightning.force.com/lightning/cmp/c__beerExplorer
        //window.location = 'https://sfcodezone-dev-ed.lightning.force.com/lightning/cmp/c__beerOrder?beerId='+component.get('v.beerId'); 
    }
})