import { LightningElement } from 'lwc';

export default class IfElseDemoLWC extends LightningElement {
    isTom = false;
    isJerry = false;
    //we must use this keyword with every property for access that property in JS
    //if you do not use this , then you can see error propertyName is not defined
    showTom(){
        this.isTom = true;
        this.isJerry = false;
    }
    showJerry(){
        this.isTom = false;
        this.isJerry = true;
    }
}