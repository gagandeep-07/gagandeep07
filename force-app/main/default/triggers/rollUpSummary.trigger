trigger rollUpSummary on Contact (after insert,after update,after delete,after undelete) {
    //This trigger perform the Roll-up Functionallty for Account - Contact 
    //Solution 1. Query Parent object with related childs    
    List<Contact> contactList = new List<Contact>();
    if(Trigger.isAfter){
        Set<Id> accountIds = new Set<Id>();
        if(Trigger.isDelete){
            contactList = Trigger.old;
        }
        else{
            contactList = Trigger.new;
        }
        for(Contact Con : contactList){
            if(Con.AccountId != null){
                accountIds.add(Con.AccountId);
            }
            if(Trigger.isUpdate){
                //Trigger.oldMap = Map<Id,sObject> so, type cast to the object
                if(Trigger.oldMap.get(Con.Id).AccountId != Con.AccountId){
                    accountIds.add(Trigger.oldMap.get(Con.Id).AccountId);
                }             
            }
        }
        //Solution 1 Query account with related contacts
        //This Solution fails when there are more than 50k contact records
        
        /*  List<Account> accList = [Select id,Name,Number_of_Contacts__c,(Select id,Name from Contacts) from Account where id IN:accountIds];
for(Account acc : accList){
List<Contact> relatedContacts = acc.Contacts;
if(relatedContacts != Null){
acc.Number_of_Contacts__c = relatedContacts.size();
}
else{
acc.Number_of_Contacts__c = 0;
}
}
update accList; */
        
        //Solution 2. Aggregate query and return type is aggregate result 
        List<Account> accountList = new List<Account>();
        List<AggregateResult> agrResult =[Select AccountId,  Count(Id) from Contact where AccountId in : accountIds Group by AccountId]; 
        /*for(AggregateResult agr : agrResult){
Id accountId = (Id)agr.get('AccountId');
Decimal count = (decimal)agr.get('expr0');
Account acc = new Account(Id=accountId,Number_of_Contacts__c = count);
accountList.add(acc);
} */
        
        Integer size = agrResult.size();
        for(Integer i = 0; i<size ; i++){
            AggregateResult agr =agrResult.get(i);
            Id accountId = (Id)agr.get('AccountId');
            Decimal count = (decimal)agr.get('expr0');
            Account acc = new Account(Id=accountId,Number_of_Contacts__c = count);
            accountList.add(acc);
            if(accountIds.contains(accountId)){
                accountIds.remove(accountId);
            }
        }
        for(Id accId : accountIds){
            Account acc = new Account(Id=accId,Number_of_Contacts__c = 0);
            accountList.add(acc);
        }
        update accountList;
        
        Map<Id,Account> accountmap = new Map<Id,Account>();
        List<Contact> conList=[Select Id , AccountId from Contact where AccountId In: accountIds]; 
        for(Contact c : conList){
            if( !accountmap.containsKey(c.AccountId)){
                accountmap.put(c.AccountId, new Account(Id=c.AccountId,Number_of_Contacts__c=1 ));
            }else{
                Account tempAccount = accountmap.get(c.AccountId);
                tempAccount.Number_of_Contacts__c +=1;
                accountmap.put(c.AccountId, tempAccount);
            }
        }
        update accountmap.values();
    } 
}