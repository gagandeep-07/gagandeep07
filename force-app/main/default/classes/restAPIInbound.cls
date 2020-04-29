/*This Class must be Global as this is accessible to External Application
Class must be annotated with @RestResource
The value for URLMapping always start with / and esnds with / in quotes. this URL mapping is the endpont for third party 
6 Anotations that enables you to expose an Apex class as a RESTful WebService.

@RestResource(urlMapping='/anyurl/' used at top of the class which tells the URL to be hit by third party.
@HttpDelete - used to delete a particular record from salesforce.
@HttpGet - to Get/Reterive the record from salesforce
@HttpPatch - used to update the existing record in salesforce If the record Does not exist in salesforce it will Create a new record in Salesforce similar to Upsert DML operation.
@HttpPost - used to create a record in salesforce.
@HttpPost -
@HttpPut - to update an existing record in salesforce 

https://instance.salesforce.com/services/apexrest/packageNamespace/yourURl/
https://instance.salesforce.com = your salesforce Org instance urlMapping
services/apexrest/ = URL which tellsthe URL is exposed via Apex Rest(Sub URL)
PackageNamespace/ = your org Namespace is any(optional)
yourUrl/ = URL that you specified in your class
*/
/*
* Get and Delete methods does not requires body. If we want to send the data then we send via URL
* https://instance.salesforce.com/services/apexrest/packageNamespace/v1/makeRecords/caseId=50032236868guyff2
* As these methods requires no body therefore no deserialization required.
* Post , Put and Patch methods requires the Body.
* if no parameter are passed in the methodthen we can get the request body using RestContext.requestBody
* To get the params from the URL use RestContext.request.params, it will return the Map<String,String> 
*/

@RestResource(urlMapping='/v1/makeRecords/')
global with sharing class restAPIInbound{
    
    @HttpGet
    global static List<Account> doGetAccount(){
        Account book = new Account();
        Map<String, String> paramsMap = RestContext.request.params;
        String accName = paramsMap.get('Id');
        string s1 = '%'+accName+'%';
        List<Account> accList = [Select Id, Name, Type From Account Where Name Like: s1];
        return accList;
    }
    @HttpPost
    global static void doCreateAccount(){
        
    }
    @HttpPut
    global static void doUpdateAccount(){
        
    }
    @HttpPatch
    global static void doUpsertAccount(){
        
    }
    @HttpDelete
    global static void doDeleteAccount(){
        
    }
    
/*
  @httpGet
    global static Book__c doGetBook(){
        Book__c book = new Book__c();
        Map<String, String> paramsMap = RestContext.request.params;
        String bookId = paramsMap.get('Id');
        book = [Select Id, Name, Price__c From Book__c Where Id =: bookId];
        return book;
    }
    
    @httpDelete
    global static String doDeleteBook(){
        Book__c book = new Book__c();
        Map<String, String> paramsMap = RestContext.request.params;
        String bookId = paramsMap.get('Id');
        book = [Select Id, Name, Price__c From Book__c Where Id =: bookId];
        delete book;
        return 'Record Deleted!';
    }
    
    @httpPost
    global static Book__c doCreateBook(BooksInfo bookInfo){
        Book__c book = bookInfo.book;
        insert book;
        return book;
    }
    @httpPut
    global static Book__c doUpdateBook(String Name){
        Map<String, String> paramsMap = RestContext.request.params;
        String bookId = paramsMap.get('Id');
        Book__c book = new Book__c(Name = name, Id = bookId);
        update book;
        return book;
    }
    
    global class BooksInfo{
        Book__c book { get; set; }
    }   
*/
}