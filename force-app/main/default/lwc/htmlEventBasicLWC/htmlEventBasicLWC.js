import { LightningElement } from 'lwc';

export default class HtmlEventBasicLWC extends LightningElement {
    
    //declaring the property in JS
    textField='This is default Text add here more  ';
    //Below is the JS method and passing the event 
    handleChange(event){
        //give the from where this method is called and get the value of the value attribute of the tag
        var varValue = event.target.value;
        //give the from where this method is called and get the value of the label attribute of the tag
        var varLabel = event.target.label;
        alert('Value is '+varValue+ 'Label is '+varLabel);
    }
}