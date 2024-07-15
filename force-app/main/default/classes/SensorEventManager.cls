@RestResource(urlMapping='/Sensor_Event__c/*')
global with sharing class SensorEventManager {
    @HttpDelete
    global static void doDelete() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String sensorEventId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Sensor_Event__c sensorEvent = [SELECT Id, Name, X_Number__c, Y_Number__c, Z_Number__c FROM Sensor_Event__c WHERE Id = :sensorEventId];
        delete sensorEvent;
    }
  
    @HttpGet
    global static Sensor_Event__c doGet() {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String sensorEventId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Sensor_Event__c result = [SELECT Id, Name, X_Number__c, Y_Number__c, Z_Number__c FROM Sensor_Event__c WHERE Id = :sensorEventId];
        return result;
    }
  
  @HttpPost
    global static String doPost(String name, Integer x, Integer y, Integer z) {
            Sensor_Event__c sensorEvent = new Sensor_Event__c(sensorEvent.Name = name, X_Number__c = , Y_Number__c = , Z_Number__c = );
            ;
        insert sensorEvent;
        return sensorEvent.Id;
    }

    @HttpPut
    global static ID upsertSensorEvent(String name, String id, Integer x, Integer y, Integer z) {
            Sensor_Event__c thisSensorEvent = new Sensor_Event__c(
                Id=id,
                Name=name,
                X_Number__c= x,
                Y_Number__c= y,
                Z_Number__c= z);
        upsert thisSensorEvent;
        return thisSensorEvent.Id;
    }
}