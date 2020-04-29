/*
* Class Name       :UtilityService
* Description      :UtilityService class for utility methods acrros classes
* Created By       :Gagandeep
* Created On       :10/11/2019

* Modification Log:
* ----------------------------------------------------------------------------------------------------------------
* Developer                Date                   Description
* ----------------------------------------------------------------------------------------------------------------
* Gagandeep              04/09/2020              Base code added
*/

global class UtilityService {
    public static string getCallingContext(){
        
        string Value;
        if (System.isBatch() || Test.isRunningTest()) 
        {
            value= 'Batch';
        }
        if (System.isFuture() || Test.isRunningTest()) 
        {
            value=  'Future';
        }
        if (System.isQueueable() || Test.isRunningTest()) 
        {
            value=  'Queueable';
        }
        if (System.isScheduled() || Test.isRunningTest()) 
        {
            value=  'Scheduled';
        }
        if (ApexPages.currentPage() != null || Test.isRunningTest()) 
        {
            value=  'ApexPage';
        }
        if (Trigger.isExecuting || Test.isRunningTest()) 
        {
            value=  'Trigger';
        }
        if (RestContext.request != null || Test.isRunningTest()) 
        {
            value=  'RestRequest';
        }
        else {
            value= 'Unknown';
        }
        
        return Value;
    }
/*
*  getGovLimitKpi - static method for setting the values
* @param  message
* @return description
*/     
    public static string getGovLimitKpi() {
        String QueryLimit = '1. SOQL Queries used / SOQL Queries allowed: ' + Limits.getQueries() + '/' + Limits.getLimitQueries();
        String DMLimit = '2. Number of records queried so far /  Number allowed: ' + Limits.getDmlRows() + '/' + Limits.getLimitDmlRows();
        String DMLStat = '3. Number of DML statements used so far / Number allowed: ' + Limits.getDmlStatements() + '/' + Limits.getLimitDmlStatements();
        String CPUT = '4. Amount of CPU time (in ms) used so far / CPU usage time (in ms) allowed: ' + Limits.getCpuTime() + '/' + Limits.getLimitCpuTime();
        return String.format('{0}\n{1}\n{2}\n{3}', new List<String> { QueryLimit, DMLimit, DMLStat, CPUT });
        
    }
/*
*  isBlankOrEmpty - used to check the blank data
* @param  inputString
* @return description
*/     
    public static Boolean isBlankOrEmpty(string inputString) {
        if (String.isBlank(inputString) || String.isEmpty(inputString)) {
            return true;
        }
        return false;
        
    }
    
/***************************************************************************************************************************************
Method Name      : getPickListMetadata
Description      : This method can be used to get the pickList metadata values
Method Parameter : String fieldName, String ObjectName
Return type      : Map<String, Object>
**************************************************************************************************************************************/
    public static List<String> getPickListMetadata(String fieldName, String ObjectName) {
        List<String> values = new List<String>();
        String[] types = new String[] {ObjectName};
            Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);
        for(Schema.DescribeSobjectResult res : results) {
            for (Schema.PicklistEntry entry : res.fields.getMap().get(fieldName).getDescribe().getPicklistValues()) {
                if (entry.isActive()) {values.add(entry.getValue());}
            }
        }
        return values;
        
    }
/*
*  getFullError - used to get the full errors 
* @param  inputString
* @return description
*/     
    public static string getFullError(List<Database.Error> errors) {
        
        //String.getCommonPrefix(List strings)
        string fullMessage = '';
        for(Database.Error error: errors) {
            fullMessage += error.getMessage();
        }
        return fullMessage;
    }
    

/**
* formatphonenum Used to get the static resuorce path.
* @param  resourceName resourceName Static resource name
* @return              return return the resurce path
*/    
    public static String formatphonenum (String s) {
        if(isBlankOrEmpty(s)) {
            return '';
        }
        
        s = s.replaceAll('\\D','');
        s = '(' + s.substring(0, 3) + ') ' + s.substring(3, 6) + '-' + s.substring(6);
        return s;
    }
    
/**
* formatphonenumdash format phone with xxx-xxx-xxxx format
* @param  s String description
* @return   return String after format
*/
    public static String formatphonenumdash (String s) {
        if(isBlankOrEmpty(s)) {
            return '';
        }
        
        s = s.replaceAll('\\D','');
        s = s.substring(0, 3) + '-' + s.substring(3, 6) + '-' + s.substring(6);
        return s;
    }
    
    static final Blob key = Blob.valueOf('1234567890123456');
    public static string encryptString(string text) {
        //16 byte string. since characters used are ascii, each char is 1 byte.
        
        //encrypted blob
        Blob cipherText = Crypto.encryptWithManagedIV('AES128', key, Blob.valueOf(text));
        //encrypted string
        String encodedCipherText = EncodingUtil.convertToHex(cipherText);
        
        return encodedCipherText;
    }
    
/**
* decryptString used to decrypt the string
* @param   text 
* @return   return decrypted String
*/
    public static string decryptString(string text) {
        Blob encodedEncryptedBlob = EncodingUtil.convertFromHex(text);
        //decrypted blob
        Blob decryptedBlob = Crypto.decryptWithManagedIV('AES128', key, encodedEncryptedBlob);
        //decrypted string
        String decryptedClearText = decryptedBlob.toString();
        return decryptedClearText;
    }
    
/**
* sleep - used to make the calling class method sleep
* @param   milliseconds 
* @return   return description
*/    
    public static void sleep(integer milliseconds)
    {
        Long timeDiff = 0;
        DateTime firstTime = System.now();
        do
        {
            timeDiff = System.now().getTime() - firstTime.getTime();
        }
        while(timeDiff <= milliseconds);
    }
    //Get Profile Id
    public static Profile getProfileIdByName(String profileType)
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
/**
* getPermissionSetIdByName - used to get the permission set by the name given
* @param   permissionName 
* @return   return permision set of the name
*/    
    public static PermissionSet getPermissionSetIdByName(String permissionName)
    {
        try
        {
            PermissionSet ps =  [SELECT Id,Label,Name FROM PermissionSet WHERE name = :permissionName LIMIT 1];
            return ps;
        }
        catch(DmlException e)
        {
            System.debug('Error during selecting permisison set');
            return null;
        }
    }


}