import { api, LightningElement } from 'lwc';

export default class SensorEventListItem extends LightningElement {
    @api sensorEvent;
    hasRecordEdit = false;
    hasRecordView = true;
    handleInput(event) {
        this.editableText = event.target.textContent;
        const fields = event.detail.fields;
    }

    editFields(event){
        this.hasRecordView = !this.hasRecordView
        this.hasRecordEdit = !this.hasRecordEdit;
    }
}