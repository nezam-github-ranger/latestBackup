public class CustomLabel {

    public String cstmLabel {get; set;}
    public CustomLabel () {
        // If you have namespace use System.Label.your_namespace.label_name
        // Here German is custom label name
        cstmLabel = System.Label.Custom_label_show_in_tab;
        System.debug('cstmLabel ==> ' + cstmLabel);
    }
    
}