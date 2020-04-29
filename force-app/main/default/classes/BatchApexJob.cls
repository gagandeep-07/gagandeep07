public class BatchApexJob {
/*
 global class ECOMM_BatchableGenerateRFQ_Items implements Database.Batchable<SObject> {
    public string query { get; set; }
    public Set<Id> prodIds = new Set<Id>();
    public Id basePriceListId { get; set; }
    public string correlationID { get; set; }
    public boolean continueProcess { get; set; }
   // public Id logRecordId { get; set; }

    global ECOMM_BatchableGenerateRFQ_Items(string correationId,boolean continueProcess){
        this.correlationID = correationId;
        this.continueProcess = continueProcess;
        this.basePriceListId  = getBasePriceListExternalIds();
        this.query='Select Id, Name,ccrz__ProductStatus__c,ccrz__SKU__c from  ccrz__E_Product__c where ccrz__ProductStatus__c IN (\'Not Orderable\',\'Released\') and ccrz__Storefront__c = \'DefaultStore\' and ECOMM_Correlation_Id__c =: correlationID';
    }
    global Database.QueryLocator start(Database.BatchableContext context) {
        ECOMM_UtilityLogger.BatchLog(context.getJobId(),correlationID);
        updatePriceListStatus(basePriceListId,'Running', context.getJobId());
        return database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext context, List<ccrz__E_Product__c > productList) {
         ECOMM_UtilityLogger.logInfo('productList from Start -->'+productList.size());
        List<ccrz__E_PriceListItem__c> newPriceListItems = new List<ccrz__E_PriceListItem__c>();
        List<ccrz__E_PriceListItem__c> priceListItems = [Select Id,Name,ccrz__Pricelist__c,ccrz__Product__c,ccrz__PricelistItemId__c from ccrz__E_PriceListItem__c 
                                                         where ((NOT ccrz__PricelistItemId__c like 'GER_RFQ_%') AND 
                                                                (ccrz__Pricelist__c =: basePriceListId) AND 
                                                                (ccrz__EndDate__c  >= Today) AND 
                                                                (ccrz__StartDate__c <= Today))];
        for(ccrz__E_PriceListItem__c pli : priceListItems){
            this.prodIds.add(pli.ccrz__Product__c);
        }
        for(ccrz__E_Product__c prod :productList){
            if(!prodIds.contains(prod.Id)){
                ccrz__E_PriceListItem__c priceListItemObj = new ccrz__E_PriceListItem__c();
                priceListItemObj.ccrz__StartDate__c= system.today()  - 1;
                priceListItemObj.ccrz__EndDate__c = Date.newInstance(2099, 12, 31);
                priceListItemObj.ccrz__Price__c = 0;
                priceListItemObj.ccrz__Product__c= prod.Id;
                priceListItemObj.ccrz__Pricelist__c=basePriceListId;
                priceListItemObj.ccrz__PricelistItemId__c ='GER_RFQ_'+prod.ccrz__SKU__c;
                priceListItemObj.ECOMM_Batch_Job_ID__c = context.getJobId();
                newPriceListItems.add(priceListItemObj);
            }  
        }
        ECOMM_UtilityLogger.logInfo('New Price List Items--- >'+newPriceListItems.size());
        if(newPriceListItems.size()>0){
            upsert newPriceListItems ccrz__PricelistItemId__c;
        }
    }
    global void finish(Database.BatchableContext context) {
        ECOMM_UtilityLogger.BatchLog(context.getJobId(),  this.correlationID);
        ECOMM_BatchableRemoveRFQ_Items batchRemoveOldREQItems = new ECOMM_BatchableRemoveRFQ_Items(basePriceListId,context.getJobId(),this.correlationID,this.continueProcess);
        database.executeBatch(batchRemoveOldREQItems, 1000);
        updatePriceListStatus(basePriceListId, 'Cleaning', context.getJobId());
    }
    
    public static String getBasePriceListExternalIds() {
        ccrz__E_PriceList__c externalBasePL = [Select Id,Name,ccrz__PricelistId__c,ECOMM_Type__c from ccrz__E_PriceList__c where ccrz__PricelistId__c=: ECOMM_UtilityConfigSettings.GetListConfigurationValue('Pricing', 'ExternalPriceListID')];
        ECOMM_UtilityLogger.logInfo(externalBasePL.Id);
        return externalBasePL.Id;
    }
    
    public static void updatePriceListStatus(Id basePriceListId, string status, string batchJobId) {
        ccrz__E_PriceList__c priceListToUpdate = new ccrz__E_PriceList__c();
        priceListToUpdate.Id = basePriceListId;
        if (!String.isBlank(batchJobId)) {
            priceListToUpdate.ECOMM_Batch_Job_ID__c = batchJobId;
        }
        priceListToUpdate.ECOMM_Batch_Job_Status__c = status;
        update priceListToUpdate;
    }
}

-------------------------------------

global class ECOMM_BatchableRemoveRFQ_Items implements Database.Batchable<SObject>{
    public string query { get; set; }
    public string filter { get; set; }
    public string pricelistItemId { get; set; }
    public string batchJobId { get; set; }
    public Id basePriceListId { get; set; }
    public string correlationID { get; set; }
    public boolean continueProcess { get; set; }    
	//public Id logRecordId { get; set; }
    global ECOMM_BatchableRemoveRFQ_Items(Id basePriceListId,Id batchJobId,string correlationID,boolean continueProcess){
        this.correlationID = correlationID;
        this.continueProcess = continueProcess;
        this.basePriceListId = basePriceListId;
        this.batchJobId = batchJobId;
        this.filter = 'GER_RFQ_';
        this.pricelistItemId = '%' + String.escapeSingleQuotes(filter.trim()) + '%';
        this.query = 'Select Id,Name,ccrz__Pricelist__c,ccrz__Product__c from ccrz__E_PriceListItem__c where ccrz__Pricelist__c =: basePriceListId and ccrz__PricelistItemId__c Like : pricelistItemId and ECOMM_Batch_Job_ID__c !=: batchJobId';
        
    }
    global Database.QueryLocator start(Database.BatchableContext context) {
        ECOMM_UtilityLogger.BatchLog(context.getJobId(),correlationID);
        return database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext context, List<ccrz__E_PriceListItem__c > pricelistItems) {
        ECOMM_UtilityLogger.logInfo(pricelistItems.size());
        if(pricelistItems.size()>0){
            delete pricelistItems;
        }
    }
    
    global void finish(Database.BatchableContext context) {
        ECOMM_UtilityLogger.BatchLog(context.getJobId(),  this.correlationID);
        if(this.continueProcess){
            ECOMM_BatchableGeneratePriceListItems runBatch = new ECOMM_BatchableGeneratePriceListItems(this.correlationID);
          database.executeBatch(runBatch,1000);
        }
        ECOMM_BatchableGenerateRFQ_Items.updatePriceListStatus(basePriceListId, 'Completed','');
    }
    
}
 */
}