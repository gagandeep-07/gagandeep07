public class beerAuraService {
    
    //This @anotation must inclued for the call the method from Controller.js Lightning CMP
    @AuraEnabled  
    public Static List<SObject> getBeerList(String searchParam){
        String query ='';
        String likeparam ='%' +searchParam+ '%';
        if(searchParam != Null){
            query ='Select Id ,Name,brewery_Name__c,Alcohol__c,Price__c,brewery_id__c,Remaining_Quantity__c,Tags__c,Total_Quantity__c,Id__c from Beer__c where name Like :likeparam limit 10';
        }
        else{
            query ='Select Id ,Name,brewery_Name__c,Alcohol__c,Price__c,brewery_id__c,Remaining_Quantity__c,Tags__c,Total_Quantity__c,Id__c from Beer__c limit 10';
        }
        List<sObject> sObjectLst = database.query(query);
        return sObjectLst;
    }
}