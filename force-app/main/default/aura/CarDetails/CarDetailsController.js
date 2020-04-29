({
    onCarSelected : function(component, event, helper) {
        component.set("v.Id", event.getParam("car").Id);
        
        component.find("service").reloadRecord();
    },
    
    onCarExpAdded : function(component, event, helper) {
        component.set("v.tabId", "carexp");
        //component.find("tabs").set("v.selectedTabId", "carexpstab");
        
        /*
         * Here we are calling a aura:method named refresh
         * which is present in CarExperiences component
         * calling to this method is not mandatory as we are
         * using change event listner in CarExperiences component
         * */
        component.find("carExpId").refresh(); 
    },
    
    onRecordUpdated : function(component, event, helper) {
        if(component.find("carExp")){
            /*
             * Here we are calling a aura:method named refresh
             * which is present in CarExperiences component
             * calling to this method is not mandatory as we are
             * using change event listner in CarExperiences component
             * */
        	component.find("carExp").refresh();
        }
    },
})