public with sharing class SensorController {
    static Integer PAGE_SIZE = 6;

    @AuraEnabled(cacheable=true)
    public static  List<Sensor__c> getSensorList() {
        List<Sensor__c> sensors = [SELECT Name,
            Max_Vectors_Length__c 
            FROM Sensor__c 
            LIMIT 10];
        return sensors;
    }

    @AuraEnabled(cacheable=true)
    public static PageResult getSensorEventTileList(String sensorId, Integer pageNumber){
        Integer pageSize = SensorController.PAGE_SIZE;
        Integer offset = (pageNumber - 1) * pageSize;
        PageResult result = new PageResult();
        result.pageSize = pageSize;
        result.pageNumber = pageNumber;
        result.totalItemCount = Database.countQuery(
            'SELECT count() FROM Sensor_Event__c WHERE Sensor__c =:sensorId'
        );
        result.records = Database.query(
            'SELECT Name, Sensor__c, X_Number__c, Y_Number__c, Z_Number__c FROM Sensor_Event__c WHERE Sensor__c =:sensorId ORDER BY Name LIMIT :pageSize OFFSET :offset'
        );
        System.debug('my result ------ ' + result);
        return result;
    }
}