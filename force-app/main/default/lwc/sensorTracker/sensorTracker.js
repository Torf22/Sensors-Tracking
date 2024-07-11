import { LightningElement, wire } from 'lwc';
import getSensorList from '@salesforce/apex/sensorController.getSensorList';

export default class SensorTracker extends LightningElement {
    selectedSensor;
    @wire(getSensorList)
    sensors;
 
    

    handleSelect(event) {
        const sensorId = event.detail;
        this.selectedSensor = this.sensors.data.find(
            (sensor) => sensor.Id === sensorId
        );
    }
}