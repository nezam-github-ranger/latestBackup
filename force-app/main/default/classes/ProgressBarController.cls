public class ProgressBarController {
    
    public Decimal deProgressBarWidth {get;set;}
    public Integer iCount {get;set;}
    public String strStatus {get;set;}
    public Boolean bProcess {get;set;}
    
    public ProgressBarController() {
        deProgressBarWidth = 0;
        strStatus = 'In Progress...';
        bProcess = true;
        iCount = 0;
    }
    
    public PageReference checkStatus() {
        // Caluclating Percentage value
        //deProgressBarWidth = (iCount != 0 ? (Decimal.valueOf(iCount) > 100 ? 100 : Decimal.valueOf(iCount))/100 * 100 : 0);
       	deProgressBarWidth = 50;
        if(iCount >= 100) {
            strStatus = 'Completed';
            bProcess = false;
        }
        else {
            strStatus = 'Processing => ' + iCount + '/100';
        }  
        
        iCount += 45;
        return null;
    }
}