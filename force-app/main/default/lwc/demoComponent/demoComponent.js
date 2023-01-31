import { LightningElement, track } from 'lwc';
import {add} from './myJs'; 

export default class DemoComponent extends LightningElement {
    car = "Maruti";

    @track carObj = {
        model : 'Toyota',
        price : 125000
    } 

    num1 = 10;
    n2 = 20;
    sum = add(this.num1,this.n2);

    person = [
        "Nick",
        "John",
        "Dilshad"
    ];

    @track personsArr = [
        {
            id:1,
            name : 'Jatin',
            age : 22  
        },
        {
            id:2,
            name : 'Rahul',
            age : 24
        },
        {
            id:3,
            name : 'Sanjay',
            age : 23
        }
    ]

    handleValue(event)
    {
        this.car = event.target.value;
        this.carObj.model = event.target.value;
    }


}