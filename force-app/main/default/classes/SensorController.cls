public with sharing class SensorController {
    @AuraEnabled(cacheable=true)
    public static List<Sensor__c> getSensorList() {
        List<Sensor__c> sensors = [SELECT Name,
            Max_Vectors_Length__c,
            (SELECT Name, X_Number__c, Y_Number__c, Z_Number__c FROM Sensor_Events__r) 
            FROM Sensor__c 
            LIMIT 10];
        return sensors;
    }
}