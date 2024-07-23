@RestResource(urlMapping='/sensorEvents/*')
global with sharing class SensorEventService {

    @HttpPost
    global static void doPost() {
        RestRequest req = RestContext.request;
        String sensorData = req.requestBody.toString();
        SensorDataWrapper data = (SensorDataWrapper) JSON.deserialize(sensorData, SensorDataWrapper.class);
        List<Sensor__c> sensors = [SELECT Id FROM Sensor__c WHERE Name = :data.sensorid LIMIT 1];
        Sensor__c sensor;
        if (sensors.isEmpty()) {
            sensor = new Sensor__c(Name = 'Created from Postman ' + data.sensorid);
            insert sensor;
        } else {
            sensor = sensors[0];
        }

        List<Sensor_Event__c> sensorEvents = new List<Sensor_Event__c>();
        for (SensorDataWrapper.Vector vector : data.vectors) {
            Sensor_Event__c event = new Sensor_Event__c(
                Name = 'Sensor Event' + data.sensorid,
                Sensor__c = sensor.Id,
                X_Number__c = vector.x,
                Y_Number__c = vector.y,
                Z_Number__c = vector.z
            );
            sensorEvents.add(event);
        }
        insert sensorEvents;
    }
}