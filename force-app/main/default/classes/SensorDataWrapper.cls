public with sharing class SensorDataWrapper {
    public String sensorid;
    public List<Vector> vectors;
    
    public class Vector {
        public Decimal x;
        public Decimal y;
        public Decimal z;
    }
}