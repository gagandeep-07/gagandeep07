/*
* Class Name       :UtilityLogger_Service
* Description      :Custom logging functionality
* Created By       :Gagandeep
* Created On       :04/09/2020

* Modification Log:
* ----------------------------------------------------------------------------------------------------------------
* Developer                Date                   Description
* ----------------------------------------------------------------------------------------------------------------
* Gagandeep           10/01/2019        As part of skeleton changes commented code which should be
* uncommented in future - Method-> createLog, createLogSync
*/
global class UtilityLogger_Service {
    
    public static void logException(Exception ex) {
        logException(ex, '');
    }
    
    /*
*  logException used to log the exception for the calling class
* @param  ex,contextId
* @return description
*/
    public static void logException(Exception ex, string contextId) {
        
        string fullMessage = string.format('Message: {0}, ExceptionType:{1}, LineNumber:{2}, StackTrace: {3}',
                                           new List<String> {
                                               ex.getMessage(), ex.getTypeName(), (ex.getLineNumber() != null ? string.valueOf(ex.getLineNumber()) : ''), ex.getStackTraceString()
                                                   });
        // if (ApexPages.currentPage() != null || (ccrz.cc_CallContext.isRemoteCall)) {
        //     ccrz.ccLog.log(System.LoggingLevel.DEBUG, 'ECOMM_EXCEPTION', fullMessage);
        //}
        //Add to debug logs
        System.debug(LoggingLevel.Error, 'ECOMM_EXCEPTION:' + fullMessage);        
    }
    
    /*
*  BatchLog used to log the Batch Info for the calling class
* @param  batchJobId,intiatingProcessId
* @return nothing
*/
    public static void BatchLog(string batchJobId, string intiatingProcessId) {
        AsyncApexJob aJob = [Select Id, Status,ExtendedStatus,NumberOfErrors, JobItemsProcessed,TotalJobItems,ApexClassID from AsyncApexJob where Id =:batchJobId];
        ApexClass aClass = [SELECT Id, Name FROM ApexClass WHERE Id =: aJob.ApexClassID];
        if (batchJobId != '')
        {                  
            system.debug(' In If condition create batch job');
            List<Utility_Log__c> logRec = [select id,Name,Data_Flow__c,Object__c,Record_Description__c,Request__c,Response__c,
                                           Source_System__c,Status__c,Status_Detail__c,Submitted_By__c,
                                           Submitted_Date__c,Submitted_Record_ID__c,Target_System__c 
                                           from Utility_Log__c where Submitted_Record_ID__c=:batchJobId];
            if(logRec.size()>0){
                logRec[0].Request__c = intiatingProcessId;
                logRec[0].Response__c = batchJobId;
                logRec[0].Source_System__c = 'ERP';
                logRec[0].Target_System__c = 'SFDC';
                if (UserInfo.getUserId() != null)
                {
                    logRec[0].Submitted_By__c = UserInfo.getUserId();
                    // logRec[0].GE_HQ_User__c = UserInfo.getUserId();
                }
                logRec[0].Record_Description__c='Batch Job Log';
                logRec[0].Submitted_Record_ID__c= batchJobId;
                logRec[0].Submitted_Date__c = system.today();
                logRec[0].Object__c = aClass.Name;
                logRec[0].Status__c = aJob.Status;
                logRec[0].Data_Flow__c = 'Inbound';
                logRec[0].Status_Detail__c = 'Number of success: ' + aJob.JobItemsProcessed + ', Number of Failure: ' + aJob.NumberOfErrors+' Number of Jobs: ' + aJob.JobItemsProcessed;
                update logRec;
                system.debug('update Utility Log id'+logRec[0].Id);
            }
            else{
                Utility_Log__c logRecord = new Utility_Log__c();
                logRecord.Request__c = intiatingProcessId;
                logRecord.Response__c = batchJobId;
                logRecord.Source_System__c = 'ERP';
                logRecord.Target_System__c = 'SFDC';
                if (UserInfo.getUserId() != null)
                {
                    logRecord.Submitted_By__c = UserInfo.getUserId();
                    //logRecord.GE_HQ_User__c = UserInfo.getUserId();
                }
                logRecord.Record_Description__c='ECOMM Batch Job';
                logRecord.Submitted_Record_ID__c= batchJobId;
                logRecord.Submitted_Date__c = system.today();
                logRecord.Object__c = aClass.Name;
                logRecord.Status__c = aJob.Status;
                logRecord.Data_Flow__c = 'Inbound';
                logRecord.Status_Detail__c = 'Number of success: ' + aJob.JobItemsProcessed + ', Number of Failure: ' + aJob.NumberOfErrors+' Number of Jobs: ' + aJob.JobItemsProcessed;
                insert logRecord;
                system.debug('first Utility Log id '+logRecord.Id);
            }
        }
    }
    
    /*
*  ApiLog used to log the API Log Info for the calling class
* @param  endpoint,request,response,status,recordSfId,objectName
* @return nothing
*/
    public static Id ApiLog(string endpoint, String request, String response, string status, string recordSfId, string objectName) {
        Utility_Log__c integrationActivity = new Utility_Log__c();
        
        integrationActivity.Request__c = request;
        if (response != null) {
            integrationActivity.Response__c = response;
        }
        integrationActivity.Source_System__c = 'SFDC';
        integrationActivity.Target_System__c = endpoint;
        if (UserInfo.getUserId() != null) {
            integrationActivity.Submitted_By__c = UserInfo.getUserId();
            //integrationActivity.GE_HQ_User__c = UserInfo.getUserId();
        }
        integrationActivity.Submitted_Date__c = system.today();
        if (!String.isBlank(objectName)) {
            integrationActivity.Object__c = objectName;
        }
        if (!String.isBlank(status)) {
            integrationActivity.Status__c = status;
        }
        integrationActivity.Data_Flow__c = 'Outbound';
        
        if (!String.isBlank(recordSfId)) {
            integrationActivity.Submitted_Record_ID__c = recordSfId;
        }
        if (status != null) {
            integrationActivity.Status_Detail__c = 'Status:' + status + ', endpoint= ' + endpoint; 
        }
        integrationActivity.Record_Description__c='API Log';
        insert integrationActivity;        
        return integrationActivity.Id;
    }
    
    /* public static Id integrationLog(String orderName, String EffectiveAcountId, String request, String response, String Logtype, String status, String NumberOfErrorsORendpoint, String JobItemsProcessed, String integrationActivityId) {
GE_HQ_Integration_Activity__c integrationActivity = new GE_HQ_Integration_Activity__c();
if (Logtype == 'order')
{
ccrz__E_Order__c order = [select id, ccrz__Contact__c, ccrz__OrderName__c from ccrz__E_Order__c where ccrz__OrderName__c = :orderName];
integrationActivity.ECOMM_Request__c = request;
if (status != null)
{
integrationActivity.ECOMM_Response__c = response;
}
integrationActivity.GE_HQ_Source_Sys__c = 'SFDC';
integrationActivity.GE_HQ_Target_Sys__c = 'SOA';
if (UserInfo.getUserId() != null)
{
integrationActivity.GE_HQ_Submit_By__c = UserInfo.getUserId();
integrationActivity.GE_HQ_User__c = UserInfo.getUserId();
}
integrationActivity.GE_HQ_Submit_Dt__c = system.today();
integrationActivity.GE_HQ_Object__c = 'CC Order';
if (status != null)
{
integrationActivity.GE_HQ_Status__c = status;
}
integrationActivity.GE_HQ_Data_Flow__c = 'Outbound';
if (EffectiveAcountId != null) {
Account acc = [select id, Name from account where GE_HQ_DUNS_Number__c = :EffectiveAcountId];
if (acc != null) {
integrationActivity.GE_HQ_Account__c = acc.Id;
}
}
integrationActivity.GE_HQ_Contact__c = order.ccrz__Contact__c;
integrationActivity.GE_HQ_Sbt_Rcrd_ID__c = order.id;
if (status != null) {
integrationActivity.GE_HQ_Status_Dtl__c = 'Status:' + status + ', endpoint= ' + NumberOfErrorsORendpoint; }
else {
integrationActivity.GE_HQ_Status_Dtl__c = response;
}
system.debug('integration activity---' + integrationActivity);
insert integrationActivity;
system.debug('integration activity inserted' + integrationActivity.Id);
if (order != null) {
order.ECOMM_Order_Integration_Log__c = integrationActivity.Id;
update order;
}

return null;
}
if (LogType == 'Inventory') {
integrationActivity.ECOMM_Request__c = 'Boomi job Id: ' + request;
integrationActivity.ECOMM_Response__c = 'Batch job id: ' + response;
integrationActivity.GE_HQ_Source_Sys__c = 'ERP';
integrationActivity.GE_HQ_Target_Sys__c = 'SFDC';
if (UserInfo.getUserId() != null)
{
integrationActivity.GE_HQ_Submit_By__c = UserInfo.getUserId();
integrationActivity.GE_HQ_User__c = UserInfo.getUserId();
}
integrationActivity.GE_HQ_Submit_Dt__c = system.today();
integrationActivity.GE_HQ_Object__c = 'CC Product Inventory Item';
integrationActivity.GE_HQ_Status__c = status;
integrationActivity.GE_HQ_Data_Flow__c = 'Inbound';
integrationActivity.GE_HQ_Status_Dtl__c = 'Number of success: ' + JobItemsProcessed + ', Number of Failure: ' + NumberOfErrorsORendpoint;
if (integrationActivityId == null)
{
insert integrationActivity;
return integrationActivity.id;
}
else {
integrationActivity = [select id, ECOMM_Request__c, ECOMM_Response__c, GE_HQ_Source_Sys__c, GE_HQ_Target_Sys__c, GE_HQ_Submit_By__c, GE_HQ_Submit_Dt__c, GE_HQ_Object__c, GE_HQ_Status__c, GE_HQ_Data_Flow__c, GE_HQ_User__c, GE_HQ_Status_Dtl__c from GE_HQ_Integration_Activity__c where id = :integrationActivityId];
integrationActivity.GE_HQ_Status__c = status;
integrationActivity.GE_HQ_Status_Dtl__c = 'Number of success: ' + JobItemsProcessed + ', Number of Failure: ' + NumberOfErrorsORendpoint;
update integrationActivity;
ECOMM_IntegrationFlag__c integrationFlag = [select id from ECOMM_IntegrationFlag__c where ECOMM_BoomiJobID__c = :request and ECOMM_IntegrationExternalID__c = :'GER_Inventory'];
if (integrationFlag != null)
{
integrationFlag.ECOMM_Is_Completed__c = False;
update integrationFlag;
}
}
}
return null;
} */
}