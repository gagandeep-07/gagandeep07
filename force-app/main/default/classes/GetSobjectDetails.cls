public class GetSobjectDetails {
    
    @AuraEnabled // this anotation must inclued for the call the method from Controller.js 
    public Static List<String> getAllSobjects(){
        List<String> sobjList = new List<String>();
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        for(String str: gd.keySet()){
            sobjList.add(str);
            system.debug('Sobject name from Key--'+str+' and value -'+gd.get(str));
        }
        return sobjList;
    }
    @AuraEnabled
    public Static List<String> getAllObjectFields(String sObjectName){
        List<String> fieldNames = new List<String>();
        // sObject types to describe
        String[] types = new String[]{sObjectName};
            // Make the describe call
            Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);
        System.debug('Got describe information for ' + results.size() + ' sObjects.');
        // For each returned result, get some info
        for(Schema.DescribeSobjectResult res : results) {
            System.debug('sObject Label: ' + res.getLabel());
            System.debug('Number of fields: ' + res.fields.getMap().size());
            System.debug(res.isCustom() ? 'This is a custom object.' : 'This is a standard object.');
            // Get child relationships
            /* Schema.ChildRelationship[] rels = res.getChildRelationships();
				if (rels.size() > 0) {
				System.debug(res.getName() + ' has ' + rels.size() + ' child relationships.');
			} */
            if(sObjectName != Null){
                map<string,SObjectField> fList = schema.getGlobalDescribe().get(sObjectName).getDescribe().fields.getMap();
                for(string str: fList.keySet()){
                    fieldNames.add(fList.get(str).getDescribe().getLabel());                
                }
            }
        }
        return fieldNames;
    }
}