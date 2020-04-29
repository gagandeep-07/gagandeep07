({
    handleClick : function(component, event, helper) {
        /* javsascript is case sensitive */
        alert(component.isValid());
        alert(component.getName());//ligthning cmp namee followed by the namespace c
        alert(component.get('v.whom'));
        //alert(component.isValid());
        component.set('v.whom','bye All');
        alert(component.get('v.whom'));
        alert('aura id Value ' +component.find('testInput').get('v.value'));
        var testId =component.find('testInput');
        alert('aura id  ' +testId.get('v.value')); 
        testId.set('v.value','qwerty');
        var map=[];
        //key and value pair
        for(var i=0 ; i<10 ; i++){
            map.push({
                key:i , value:'map'+i
            })
            }
                component.set('v.mapValue',map);
            }
            })