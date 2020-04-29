/*
* Class Name       :UtilityTestDataFactory
* Description      :Test data factory setup
* Created By       :Gagandeep
* Created On       :04/09/2020

* Modification Log:
* ----------------------------------------------------------------------------------------------------------------
* Developer                Date                   Description
* ----------------------------------------------------------------------------------------------------------------
* Gagandeep              04/09/2020              test data setup for custom objects
*/

@isTest
public with sharing class UtilityTestDataFactory {
    //public static final String CLOUDCRAZE_CUSTOMER_COMMUNITY_PROFILE_NAME = 'CloudCraze Customer Community User';
    
    public static Account createAccount(){
        Account acc = new Account(Name='North America Accounts');
        insert acc;
        return acc;
    }
    
    public static Contact createContact(){
        Contact con = new Contact(firstName='Bob',lastName='Marley');
        insert con;
        return con;
    }
    
    //Retrieve Record Type
    public static Map<String, RecordType> getRecordType(String sObjName)
    {
        Map<String, RecordType> recordTypeMap = new Map<string,RecordType>();
        for(RecordType r : [Select r.SobjectType, r.Name, r.Id From RecordType r where r.IsActive = true AND r.SobjectType=:sObjName])
        {
            recordTypeMap.put(r.Name, r);
        }
        return recordTypeMap;
    }
    
    //Get Profile Id
    public static Profile getProfileId(String profileType)
    {
        try
        {
            Profile p = [Select p.UserType, p.UserLicenseId, p.Name, p.Id From Profile p where p.Name=:profileType LIMIT 1];
            return p;
        }
        catch(DmlException e)
        {
            System.debug('Error during selecting profile');
            return null;
        }
    }
    
    //Get Admin User
    public static User getAdminUsr()
    {
        Profile p = getProfileId('System Administrator');
        User admin= [Select u.Username, u.UserType, u.UserRoleId, u.Title, u.TimeZoneSidKey, u.ProfileId, u.LocaleSidKey, u.LastName,
                     u.LanguageLocaleKey, u.Id, u.FirstName, u.EmailEncodingKey, u.Email, u.CommunityNickname, u.Alias
                     From User u where u.profileId=:p.Id AND u.IsActive=true LIMIT 1];
        return admin;
    }
    
    //Create new User
    public static User getNewUser(String usrName, String usrEmail, String aliasName, String profilesId, String empId)
    {
        User usr = new User(LastName='Test Smith', EmailEncodingKey='ISO-8859-1', LanguageLocaleKey = 'en_US',
                            Email=usrEmail, Alias=aliasName, Username=usrName, CommunityNickname='Test '+System.currentTimeMillis().format());
        
        usr.ProfileId = profilesId;
        usr.TimeZoneSidKey = 'America/Chicago';
        usr.LocaleSidKey='en_US';
        
        return usr;
    }
    
    //Get Admin User
    public static User getUsrByProfile(String profile)
    {
        User admin =null;
        Profile p = getProfileId(profile);
        if(p != null) {
            admin= [Select u.Username, u.UserType, u.UserRoleId, u.Title, u.TimeZoneSidKey, u.ProfileId, u.LocaleSidKey, u.LastName,
                    u.LanguageLocaleKey, u.Id, u.FirstName, u.EmailEncodingKey, u.Email, u.CommunityNickname, u.Alias
                    From User u where u.profileId=:p.Id AND u.IsActive=true LIMIT 1];
        }
        return admin;
    }
    
    //Empty, Null value check method
    public static boolean isEmpty(String val)
    {
        if((val==null)|| (val==''))
        {
            return true;
        }
        else if(val.trim()=='')
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    
    public static User createAdminUser(){
        //UserRole r = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role');
        //insert r;
        List<Profile> Profilelist=new List<Profile>();
        Profilelist = [Select Id,name From Profile Where Name='System Administrator'];
        
        User u = new User(
            ProfileId = Profilelist[0].Id,
            lastName='Test',
            Email = 'admin@ge.com',
            Username = 'test007@test.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
            //UserRoleId = r.Id
        );
        insert u;
        return u;
    }
}