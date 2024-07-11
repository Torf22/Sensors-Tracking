import { LightningElement, api } from 'lwc';

export default class SensorListItem extends LightningElement {
     
    @api sensor;

    handleClick(event) {
        event.preventDefault();
        const selectEvent = new CustomEvent('select', {
            detail: this.sensor.Id
        });
        this.dispatchEvent(selectEvent);
    }
}