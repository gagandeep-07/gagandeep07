import { LightningElement } from 'lwc';

export default class IteratorDemoLWC extends LightningElement {
    contacts = [
        {
            Id : 1,
            Name : "Amit Sing",
            Email : "sfdcpanther@gmail.com"
        },
        {       
            Id : 2,
            Name : "Gagan verma",
            Email : "gagan_verma07@outlook.com"
        },
        {
            Id : 3,
            Name : "Ankit Sing",
            Email : "ankit@hotmail.com"
        }
    ]
}