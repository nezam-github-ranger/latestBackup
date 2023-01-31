import { LightningElement, track } from 'lwc';
export default class JitendraAssignment extends LightningElement {
    
    isCheck = false;
    @track data = [
        {
            'name' : 'requiredField',
            'type' : 'text',
            'label' : 'Required Name',
            'placeholder' : 'Enter Required : ',
            'value' : '',
            'required' : true,
            'style' : 'padding: 2px; color: blue;'
        },
        {
            'name' : 'name1',
            'type' : 'text',
            'label' : 'S Name',
            'placeholder' : 'Enter Name : ',
            'value' : '',
            'required' : false
        },
        {
            'name' : 'phone1',
            'type' : 'number',
            'label' : 'S Number',
            'placeholder' : 'Enter Phone Number : ',
            'value' : '',
            'required' : false
        },
        {
            'name' : 'zip1',
            'type' : 'number',
            'label' : 'S Zip',
            'placeholder' : 'Enter Zip : ',
            'value' : '',
            'required' : false
        },
        {
            'name' : 'address1',
            'type' : 'text',
            'label' : 'S Address',
            'placeholder' : 'Enter Address',
            'value' : '',
            'required' : false
        },
        {
            'name' : 'checkbox',
            'type' : 'checkbox',
            'label' : 'Secondary Address',
            'placeholder' : 'Secondary Address ',
            'value' : this.isCheck,
            'required' : false
        },
        {
            'name' : 'name2',
            'type' : 'text',
            'label' : 'S Name',
            'placeholder' : 'Enter Name : ',
            'value' : '',
            'required' : false
        },
        {
            'name' : 'phone2',
            'type' : 'number',
            'label' : 'S Number',
            'placeholder' : 'Enter Phone Number : ',
            'value' : '',
            'required' : false
        },
        {
            'name' : 'zip2',
            'type' : 'number',
            'label' : 'S Zip',
            'placeholder' : 'Enter Zip : ',
            'value' : '',
            'required' : false
        },
        {
            'name' : 'address2',
            'type' : 'text',
            'label' : 'S Address',
            'placeholder' : 'Enter Address',
            'value' : '',
            'required' : false
        }
    ];

    callOnChange(event){
        console.log('event name ==> ', event.target.name);
        console.log('event value ==> ', event.target.value);
        
        if(event.target.name == 'checkbox'){
            this.isCheck = this.isCheck == false ? true : false;
            if(this.isCheck){
                let i=0;
                let startFrom = Math.trunc(this.data.length / 2);
                console.log('startFrom ==> ', startFrom);
                for(startFrom; startFrom < this.data.length ; startFrom++) {
                    if(this.data[i].name != 'checkbox' || this.data[i].name != 'requiredField'){
                        this.data[startFrom + 1].value = this.data[i++].value;
                        console.log('data in if ==> ', this.data);
                        console.log('i => ', i , ' || startFrom => ', startFrom);
                    }else{
                        ++i;
                        --startFrom;
                        console.log('in else i => ', i , ' || startFrom => ', startFrom);
                    }
                }
            }else{
                let startFrom = Math.trunc(this.data.length / 2);
                for(++startFrom; startFrom < this.data.length ; startFrom++) {
                    this.data[startFrom].value = '';    
                }    
            }
        }else{
            var index = this.data.findIndex(item => item.name === event.target.name);
            this.data[index].value = event.target.value;
        }
        console.log('data ==> ', this.data);
        console.log('log', JSON.stringify(this.data));
    }
}