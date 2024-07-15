import { LightningElement, api, track } from 'lwc';

export default class SensorListItem extends LightningElement {
    @api selectedSensor;
    @api sensor;
    isOpen = false;

    handleClick(event) {
        if(!this.isOpen){
            this.openModal();
        } else {
            this.closeModal();
        }
        

        event.preventDefault();
        const selectEvent = new CustomEvent('select', {
            detail: this.sensor.Id
        });
        this.dispatchEvent(selectEvent);
    }

     openModal() {
        this.isOpen = true;
    }

    closeModal() {
        this.isOpen = false;
    }
}