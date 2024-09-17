@isTest
private class SensorEventServiceTest {
    @isTest
    static void testDoPost() {
        String jsonData = '{"sensorid": "TestSensor", "vectors": [{"x": 22, "y": 17, "z": 197}, {"x": 23, "y": 45, "z": 14}, {"x": 22, "y": 43, "z": 196}, {"x": 24, "y": 42, "z": 198}]}';
        
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/sensorEvents';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(jsonData);
        RestContext.request = req;

        RestResponse res = new RestResponse();
        RestContext.response = res;
        
        Test.startTest();
        SensorEventService.doPost();
        Test.stopTest();

        Sensor__c sensor = [SELECT Id, Name FROM Sensor__c WHERE Name = 'TestSensor' LIMIT 1];
        System.assertNotEquals(null, sensor, 'Sensor record should be created');
        System.assertEquals('TestSensor', sensor.Name, 'Sensor name should be TestSensor');

        List<Sensor_Event__c> events = [SELECT Id, X_Number__c, Y_Number__c, Z_Number__c FROM Sensor_Event__c WHERE Sensor__c = :sensor.Id];
        System.assertEquals(4, events.size(), 'There should be 4 sensor events created');

        System.assertEquals(22, events[0].X_Number__c);
        System.assertEquals(17, events[0].Y_Number__c);
        System.assertEquals(197, events[0].Z_Number__c);

        System.assertEquals(23, events[1].X_Number__c);
        System.assertEquals(45, events[1].Y_Number__c);
        System.assertEquals(14, events[1].Z_Number__c);

        System.assertEquals(22, events[2].X_Number__c);
        System.assertEquals(43, events[2].Y_Number__c);
        System.assertEquals(196, events[2].Z_Number__c);

        System.assertEquals(24, events[3].X_Number__c);
        System.assertEquals(42, events[3].Y_Number__c);
        System.assertEquals(198, events[3].Z_Number__c);
    }
}  