({
	handleKeyUp: function (cmp, evt) {
        var isEnterKey = evt.keyCode === 13;
        var queryTerm = cmp.find('enter-search').get('v.value');
        if (isEnterKey) {
            cmp.set('v.issearching', true);
            setTimeout(function() {
                alert('Searched for "' + queryTerm + '"!');
                cmp.set('v.issearching', false);
            }, 2000);
        }
    },
    
    doSearch: function (component, evt,heandler){
        var componentevent = component.getEvent('BeerEvent');
        var serachParam = component.find('enter-search').get('v.value');
        componentevent.setParams({
            searchText:serachParam
        });
        componentevent.fire();        
    },
})