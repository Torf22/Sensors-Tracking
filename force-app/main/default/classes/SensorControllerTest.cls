@IsTest
public class SensorControllerTest {
    
    @TestSetup
    static void setup() {
        List<Sensor__c> sensors = new List<Sensor__c>();
        for (Integer i = 0; i < 5; i++) {
            Sensor__c sensor = new Sensor__c(Name = 'Sensor ' + i);
            sensors.add(sensor);
        }
        insert sensors;

        List<Sensor_Event__c> sensorEvents = new List<Sensor_Event__c>();
        for (Sensor__c sensor : sensors) {
            for (Integer j = 0; j < 3; j++) {
                Sensor_Event__c event = new Sensor_Event__c(
                    Name = 'Event ' + j, 
                    X_Number__c = 10 + j, 
                    Y_Number__c = 20 + j, 
                    Z_Number__c = 30 + j, 
                    Sensor__c = sensor.Id
                );
                sensorEvents.add(event);
            }
        }
        insert sensorEvents;
    }

    @IsTest
    static void testGetSensorList() {
        Test.startTest();
        List<Sensor__c> sensors = SensorController.getSensorList();
        Test.stopTest();

        System.assertNotEquals(null, sensors, 'sensors is null');
        System.assert(sensors.size() > 0, 'sensor is 0');
        for (Sensor__c sensor : sensors) {
            System.assertNotEquals(null, sensor.Name, 'Name is null');
            System.assert(sensor.Max_Vectors_Length__c != null, 'Max_Vectors_Length__c is null');
            System.assertNotEquals(null, sensor.Sensor_Events__r, 'Sensor_Events__r is null');
            System.assert(sensor.Sensor_Events__r.size() > 0, 'is');
            for (Sensor_Event__c event : sensor.Sensor_Events__r) {
                System.assertNotEquals(null, event.Name, 'Name is null');
                System.assert(event.X_Number__c != null, 'X_Number__c is null');
                System.assert(event.Y_Number__c != null, 'Y_Number__c is null');
                System.assert(event.Z_Number__c != null, 'Z_Number__c is null');
            }
        }
    }
}
