/*
* Class Name       :UtilityServiceTest
* Description      :UtilityServiceTest class for utility methods acrros classes
* Created By       :Gagandeep
* Created On       :10/11/2019

* Modification Log:
* ----------------------------------------------------------------------------------------------------------------
* Developer                Date                   Description
* ----------------------------------------------------------------------------------------------------------------
* Gagandeep              04/09/2020              Base code added
*/

@isTest
public class UtilityServiceTest {
    
    public @IsTest   static void isBlankOrEmptyTest(){
        Test.startTest();
        String message= '';
        UtilityService.isBlankOrEmpty(message);
        message = 'Testing Blank';
        UtilityService.isBlankOrEmpty(message);
        Test.stopTest();
        
    }
    /**
* getGovLimitKpiTest Used in getting the gov limit.
* @param  
* @return	return - covers the calling class code.
*/     
    public @IsTest   static void getGovLimitKpiTest(){
        Test.startTest();
        List<User> listName = [SELECT Id,Email from User LIMIT 5];
        UtilityService.getGovLimitKpi();
        Test.stopTest();
    }
    
    public @IsTest   static void getPickListMetadataTest(){
        Test.startTest();
        UtilityService.getPickListMetadata('ccrz__Employment_Level__c','ccrz__E_Product__c');
        Test.stopTest();
    }
    
    public @IsTest   static void getCallingContextTest(){
        Test.startTest();
        UtilityService.getCallingContext();
        callingContext();
        Test.stopTest();
    }
    
    @future
    public static void callingContext(){
        UtilityService.getCallingContext();
    }
    
    public @IsTest static void sleep(){
        Test.startTest();
        UtilityService.sleep(2000);
        Test.stopTest();
    }
    
    public @IsTest static void decryptString(){
        Test.startTest();
        String encrypt = UtilityService.encryptString('2000');
        UtilityService.decryptString(encrypt);
        Test.stopTest();
    }
    
    public @IsTest static void formatphonenum(){
        Test.startTest();
        UtilityService.formatphonenum('9999999999');
        UtilityService.formatphonenum('');
        Test.stopTest();
    }
    
    public @IsTest static void formatphonenumdash(){
        Test.startTest();
        UtilityService.formatphonenumdash('9999999999');
        UtilityService.formatphonenumdash('');
        //UtilityService.getResourcePath();
        Test.stopTest();
    }
    
    public @IsTest static void getProfileIdByName(){
        Test.startTest();
        //Profile p = [Select p.UserType, p.UserLicenseId, p.Name, p.Id From Profile p where p.Name='System Administratorr' LIMIT 1];
        try {
            UtilityService.getProfileIdByName('System Administrator');
        } catch (Exception e) {
        }
        
        
        Test.stopTest();
    }
    
    public @IsTest static void getPermissionSetByName(){
        Test.startTest();
        //PermissionSet ps =  [SELECT Id,Label,Name FROM PermissionSet WHERE name = 'Marketplace_User' LIMIT 1];
        try {
            UtilityService.getPermissionSetIdByName('B2BCommerceAdmin');
        } catch (Exception e) {
        }
        
        Test.stopTest();
    }
    
    public @IsTest static void getFullError(){
        Test.startTest();
        //PermissionSet ps =  [SELECT Id,Label,Name FROM PermissionSet WHERE name = 'Marketplace_User' LIMIT 1];
        Account acc = new Account(Name='test Account');
        Database.Saveresult res = Database.Insert(acc);
        List<Database.Error> err = new  List<Database.Error>();
        err = res.getErrors();
        UtilityService.getFullError(err);
        Test.stopTest();
    }
}