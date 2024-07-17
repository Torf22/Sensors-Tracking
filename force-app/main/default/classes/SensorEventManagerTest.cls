@isTest
private class SensorEventManagerTest {
    @TestSetup
    static void setup() {
        Sensor__c testSensor = new Sensor__c(Name = 'Test Sensor');
        insert testSensor;
        Sensor_Event__c testEvent = new Sensor_Event__c(Name = 'Test Event', Sensor__c = testSensor.Id, X_Number__c = 10, Y_Number__c = 20, Z_Number__c = 30);
        insert testEvent;
    }
    
    @IsTest
    static void testDoPost() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Sensor_Event__c';
        req.httpMethod = 'POST';
        req.addParameter('name', 'New Event');
        req.addParameter('x', '100');
        req.addParameter('y', '200');
        req.addParameter('z', '300');
        RestContext.request = req;
        RestContext.response = res;
        Id testSensorId = [SELECT Id FROM Sensor__c LIMIT 1].Id;
        

        Test.startTest();
        Id newEventId = SensorEventManager.doPost('New Event', testSensorId, 100, 200, 300);
        Test.stopTest();

        Sensor_Event__c newEvent = [SELECT Id, Name, X_Number__c, Y_Number__c, Z_Number__c FROM Sensor_Event__c WHERE Id = :newEventId];
        System.assertEquals('New Event', newEvent.Name);
        System.assertEquals(100, newEvent.X_Number__c);
        System.assertEquals(200, newEvent.Y_Number__c);
        System.assertEquals(300, newEvent.Z_Number__c);
    }

    @IsTest
    static void testDoGet() {
        Sensor_Event__c existingEvent = [SELECT Id FROM Sensor_Event__c LIMIT 1];
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Sensor_Event__c/' + existingEvent.Id;
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        Sensor_Event__c fetchedEvent = SensorEventManager.doGet();
        Test.stopTest();

        // Verify that the correct record was fetched
        System.assertNotEquals(null, fetchedEvent);
        System.assertEquals(existingEvent.Id, fetchedEvent.Id);
    }

    @IsTest
    static void testDoPut() {
        Sensor_Event__c existingEvent = [SELECT Id FROM Sensor_Event__c LIMIT 1];
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Sensor_Event__c/' + existingEvent.Id;
        req.httpMethod = 'PUT';
        req.addParameter('name', 'Updated Event');
        req.addParameter('x', '400');
        req.addParameter('y', '500');
        req.addParameter('z', '600');
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        ID updatedEventId = SensorEventManager.upsertSensorEvent('Updated Event', existingEvent.Id, 400, 500, 600);
        Test.stopTest();

        // Verify that the record was updated
        Sensor_Event__c updatedEvent = [SELECT Id, Name, X_Number__c, Y_Number__c, Z_Number__c FROM Sensor_Event__c WHERE Id = :updatedEventId];
        System.assertEquals('Updated Event', updatedEvent.Name);
        System.assertEquals(400, updatedEvent.X_Number__c);
        System.assertEquals(500, updatedEvent.Y_Number__c);
        System.assertEquals(600, updatedEvent.Z_Number__c);
    }

    @IsTest
    static void testDoDelete() {
        Sensor_Event__c existingEvent = [SELECT Id FROM Sensor_Event__c LIMIT 1];
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Sensor_Event__c/' + existingEvent.Id;
        req.httpMethod = 'DELETE';
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        SensorEventManager.doDelete();
        Test.stopTest();

        // Verify that the record was deleted
        List<Sensor_Event__c> deletedListEvents = [SELECT Id FROM Sensor_Event__c WHERE Id = :existingEvent.Id AND isDeleted = TRUE ALL ROWS];
        System.assertEquals(1, deletedListEvents.size());
    }
}  