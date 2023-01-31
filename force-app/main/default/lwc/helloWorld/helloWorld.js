import { LightningElement, track } from 'lwc';

export default class HelloWorld extends LightningElement {

    name = "LWC Class"

    arr = [10,20,30,40];
    arrElement = this.arr[0];

    person = {
        name : this.name,
        age : 22
    }

    @track personsArr = [
        {
          name : 'Jatin',
          age : 22  
        },
        {
            name : 'Rahul',
            age : 24
        },
        {
            name : 'Sanjay',
            age : 23
        }
    ]

    num1 = 10;
    num2 = 20;
    
    get sum(){
        return this.num1 + this.num2;
    }

    isVisible = false;

    handleClick(){
        this.isVisible = this.isVisible === true ? false : true;
    }

    get personName(){
        return this.personsArr[0].name === 'Hello' ? this.personsArr[0].name : "Go";
    } 

    handleValue(event){
       this.name = event.target.value;
       this.person.name = event.target.value;
       this.personsArr[0].name = event.target.value;           
       //this.personName = this.personsArr[0].name;
    } 

}