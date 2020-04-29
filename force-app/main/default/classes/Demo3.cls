public class Demo3 {
    
    public void mainValueMethod(){
        String websiteURL ='Apex hours';
        system.debug('Before calling value call '+websiteURL);
        passByValueCall(websiteURL);
        system.debug('Before calling value call '+websiteURL);
    }
    private void passByValueCall(String websiteURLValue){
        websiteURLValue ='Salesforce';
    }
    
    public void mainReferenceMethod(){
        Account a = new Account();
        a.Name='Test Account';
        a.Website='www.apexhours.com';
        system.debug('Before calling reference call '+a);
        passByReferenceCall(a);
        system.debug('Before calling reference call '+a);
    }
    private void passByReferenceCall(Account a1){
        a1.Website ='www.Salesforce.com';
    }
}