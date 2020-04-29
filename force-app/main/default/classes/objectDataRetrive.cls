global class objectDataRetrive {
    
    @AuraEnabled // this anotation must inclued for the call the method from Controller.js 
    public Static List<Contact> getContactList(String accId){
        List<Contact> conLst = new List<Contact>([Select FirstName,Email from Contact where email != Null AND AccountId =:accId]);
        return conLst;
    }
    @AuraEnabled
    public Static Contact createContact(Contact Con,Id accId){
        Con.AccountId= accId;
        insert Con;
        return Con;
    }
    @AuraEnabled // this anotation must inclued for the call the method from Controller.js 
    public Static List<SObject> getBeerList(String searchParam){
        String query ='';
        String likeparam ='%' +searchParam+ '%';
        if(searchParam != Null){
            query ='Select Id ,Name,brewery_id__c from Beer__c where name Like :likeparam';
        }
        else{
            query ='Select Id ,Name,brewery_Name__c,Alcohol__c,Price__c,brewery_id__c from Beer__c';
        }
        List<sObject> sObjectLst = database.query(query);
        return sObjectLst;
    }
}