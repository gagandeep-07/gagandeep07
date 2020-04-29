import { LightningElement,api } from 'lwc';

export default class MetafileExampleLWC extends LightningElement {
    //Meta file has these 2api property declared 
    @api message;
    @api pageno;
}