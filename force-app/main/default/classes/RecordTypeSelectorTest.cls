@isTest
public class RecordTypeSelectorTest {
	@isTest
    public static void testRecordTypeSelector(){
        Map<Id, String> mapOfRecordType = RecordTypeSelector.fetchRecordTypeValues('Contact');
        System.assert(mapOfRecordType!=null);
    }
}