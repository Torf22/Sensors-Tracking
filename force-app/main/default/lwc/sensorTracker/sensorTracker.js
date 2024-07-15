import { LightningElement, wire } from 'lwc';
import getSensorList from '@salesforce/apex/sensorController.getSensorList';

export default class SensorTracker extends LightningElement {
    selectedSensor;
    hasSensorEvents;
    sensorEvents;
    @wire(getSensorList)
    sensors;



    handleSelect(event) {
        const sensorId = event.detail;
        this.selectedSensor = this.sensors.data.find(
            (sensor) => sensor.Id === sensorId
        );

        if (this.selectedSensor && this.selectedSensor.Sensor_Events__r) {
            this.hasSensorEvents = this.selectedSensor.Sensor_Events__r;
        } 
        console.log('events ---- '+ this.selectedSensor.Sensor_Events__r); 
    }
}