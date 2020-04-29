/* First trigger on Account object
*  Author : Gaganndeep Verma
*  Context variables
*/
trigger myFirstTrigger on Account (before insert,before update,before delete,after insert,after update,after delete,after undelete) {
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        system.debug('Size of trigger new events '+trigger.new.size());
    } 
    if(trigger.isAfter && Trigger.isUpdate){
        system.debug('Size of trigger old events '+trigger.old.size());
    }
    
    //  system.debug('Trigger execution '+trigger.isExecuting());    
    if(Trigger.isBefore){
        system.debug('before events ');
        if(Trigger.isInsert){
            system.debug('i am in inside before insert ');
        }
        else if(Trigger.isUpdate){
            system.debug('i am in inside before update ');
        }
        else if(Trigger.isdelete){
            system.debug('i am in inside before delete ');
        }        
        system.debug('Trigger.New events '+trigger.new);
        system.debug('Trigger.Old events '+trigger.old);
        system.debug('Trigger.newMap events '+trigger.newMap);
        system.debug('Trigger.oldMap events '+trigger.oldMap);    
    }
    else if(trigger.isAfter){
        system.debug('after events ');
        if(Trigger.isInsert){
            system.debug('i am in inside after insert ');
        }
        else if(Trigger.isUpdate){
            system.debug('i am in inside after update ');
        }
        else if(Trigger.isdelete){
            system.debug('i am in inside after delete ');
        } 
        system.debug('Trigger.New events '+trigger.new);
        system.debug('Trigger.Old events '+trigger.old);
        system.debug('Trigger.newMap events '+trigger.newMap);
        system.debug('Trigger.oldMap events '+trigger.oldMap);            
    }
    
}