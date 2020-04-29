trigger accountTrigger on Account (before delete) {
//trigger.old = lit of <sobject> = list<account>
//trigger.oldMap = map<id,sobject> = map<id,account>
//keySet() 
//
Set<id> accountIdsSet =Trigger.oldMap.keySet();
    List<Opportunity> oppList = new  List<Opportunity>();
}