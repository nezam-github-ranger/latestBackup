public class CheckboxController {
    
    public Boolean checkbox1 {get;set;}
    public Boolean checkbox2 {get;set;}
    
    public String checkbox1Value {get;set;}
    public String checkbox2Value {get;set;}
    public String selectedCheckboxValue {get;set;}
    
    public CheckboxController(){
        checkbox1 = false;
        checkbox2 = false;
        checkbox1Value = 'First Checkbox';
        checkbox2Value = 'Second Checkbox';
    }
    
    public void changeMethodCall(){
        
    }
}