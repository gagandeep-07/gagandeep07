public class RecordEditFormServerController {
    
    @AuraEnabled
    public static void saveRecord(Car__c car){
        update car;
    }

}