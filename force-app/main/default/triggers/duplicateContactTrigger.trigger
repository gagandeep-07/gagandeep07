trigger duplicateContactTrigger on Contact (before insert,before update,after undelete) {
    //This trigger is to prevent of inserting , updating and undeletion of duplicate contact record with Email
    //Get list of all new reocrds
    //Trigger.new
    List<Contact> contList = new List<Contact>();
    Set<String> newEmails = new Set<String>();
    Set<String> existingEmails = new Set<String>();
    
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        contList = Trigger.new;
    }   
    if(Trigger.isAfter && Trigger.isUndelete){
        contList = trigger.new;
    }
    //Step 2 Add all new email in set
    for(Contact Con :contList){
        if(Con.Email != Null){
            newEmails.add(Con.Email);
        }
    }
    //Step 3 Make a SOQL on Contact with NewEmail set check for the duplicate emails in salesforce
    List<Contact> existingContactList = [Select id,Name,Email,FirstName,LastName from Contact where Email in: newEmails and Email != Null];
    for(Contact Cont : existingContactList){
        existingEmails.add(Cont.Email);
    }
    //step 4 Iterate to New contact records and check the email is maching with existing email set and add Error
    for(Contact Conlist : contList){
        if(existingEmails.contains(Conlist.Email)){
            Conlist.Email.AddError('Duplicate Email is not Allowed on Contact');
        }else{
            existingEmails.add(Conlist.Email);
        }
    }
}