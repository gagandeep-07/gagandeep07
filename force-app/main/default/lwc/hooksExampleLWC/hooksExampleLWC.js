import { LightningElement } from 'lwc';

export default class HooksExampleLWC extends LightningElement {

constructor(){
    super();
    console.log('inside Constructor');
}
connectedCallback(){
    console.log('inside connectedCallback');
}
disconnectedCallback(){
    console.log('inside disconnectedCallback');
}
/*
render(){
    console.log('inside render');
}
renderedCallback(){
    console.log('inside renderedCallback');
}
errorCallback(error, stack){
    console.log('inside errorCallback');

}
*/
}