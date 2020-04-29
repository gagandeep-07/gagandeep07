import { LightningElement, track, api } from 'lwc';

export default class PropertyDemoLWC extends LightningElement {
    //Private non-reactive property
    //Non-reactive proprty means, when property value changes in JS and the same value is not rendered on component
    @track message = 'Non-Reactive Property';
    @api message1 = 'Reactive Property using @api decorators';

    handleChange(event){
        this.message = event.target.value;
        this.message1 = event.target.value;

        console.log(' Updated Message is ', this.message);
    }

    //Getter property for getting the value without crating any variable
    get name(){
        return 'Gagan verma'
    }
    //Modifying the value of any property
    get changeValue(){
        return this.message1+' LWC Champion';
    }
}