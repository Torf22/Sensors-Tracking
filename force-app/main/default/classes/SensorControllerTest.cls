@isTest
public class SensorControllerTest {
    
    static void setupTestData() {
        List<Sensor__c> sensors = new List<Sensor__c>();
        for (Integer i = 0; i < 5; i++) {
            sensors.add(new Sensor__c(
                Name = 'Sensor ' + i
            ));
        }
        insert sensors;
        
        List<Sensor_Event__c> sensorEvents = new List<Sensor_Event__c>();
        for (Sensor__c sensor : sensors) {
            for (Integer i = 0; i < 10; i++) {
                sensorEvents.add(new Sensor_Event__c(
                    Name = 'Event ' + i,
                    Sensor__c = sensor.Id,
                    X_Number__c = i,
                    Y_Number__c = i + 1,
                    Z_Number__c = i + 2
                ));
            }
        }
        insert sensorEvents;
    }

    @isTest
    static void testGetSensorList() {
        setupTestData();
        
        Test.startTest();
        List<Sensor__c> result = SensorController.getSensorList();
        Test.stopTest();
        
        System.assertNotEquals(0, result.size());
        System.assert(result.size() <= 10);
    }

    @isTest
    static void testGetSensorEventTileList() {
        setupTestData();
        
        Sensor__c sensor = [SELECT Id FROM Sensor__c LIMIT 1];
        
        Test.startTest();
        PageResult result = SensorController.getSensorEventTileList(sensor.Id, 1);
        Test.stopTest();

        System.assertNotEquals(null, result);
        System.assertEquals(1, result.pageNumber);
        System.assert(result.records.size() > 0);
    }
}
