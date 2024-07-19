import { LightningElement, track, wire } from 'lwc';
import getSensorList from '@salesforce/apex/sensorController.getSensorList';
import getSensorEventTileList from '@salesforce/apex/sensorController.getSensorEventTileList';

export default class SensorTracker extends LightningElement {
    selectedSensor;
    hasSensorEvents;
    sensorEvents;
    sensorId;
    pageSize;
    pageNumber = 1;
    totalItemCount = 0;
    @wire(getSensorList)
    sensors;
    @wire(getSensorEventTileList, { sensorId: '$sensorId', pageNumber: '$pageNumber' })
    wiredSensorEvents({ error, data }) {
        if (data) {
            this.sensorEvents = data.records;
            this.totalItemCount = data.totalItemCount;
            this.pageNumber = data.pageNumber;
            this.pageSize = data.pageSize;
            if (this.selectedSensor) {
                this.hasSensorEvents = true;
            }
        } else if (error) {
            this.sensorEvents = undefined;
            this.hasSensorEvents = false;
            console.error('Error fetching sensor events: ', error);
        }
    }



    handleSelect(event) {
        this.sensorId = event.detail;
        if (this.sensors && this.sensors.data) {
            this.selectedSensor = this.sensors.data.find(
                (sensor) => sensor.Id === this.sensorId
            );
        }

        if (this.selectedSensor && this.sensorEvents) {
            this.hasSensorEvents = true;
            this.pageNumber = 1;
        } else {
            this.hasSensorEvents = false;
        } 
    }

    handlePreviousPage() {
        this.pageNumber = this.pageNumber - 1;
    }

    handleNextPage() {
        this.pageNumber = this.pageNumber + 1;
    }
}