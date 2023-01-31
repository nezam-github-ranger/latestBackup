global class CalculateTotalHoursAssign implements Schedulable {
    
    global CalculateTotalHoursAssign(){
        System.debug('Controoller');
    }
    
    global void execute(SchedulableContext SC) {
        calculateAssignHours();
    }
    
    public static void calculateAssignHours(){
        List<Account> updateTotalHoursAssign = new List<Account>();
        for(Account acc: [SELECT Id, Name, Assign_Date__c, Total_Hours_Assign__c FROM Account WHERE Assign_Date__c != null]){
        	
            Datetime startDate = acc.Assign_Date__c;
            Datetime endDate = System.now();
            
            System.debug('startDate ==> ' + startDate);
            System.debug('endDate ==> ' + endDate);
            
            Integer noOfDays = startDate.Date().daysBetween(endDate.Date());
            System.debug('No Of Days : ' + noOfDays);
            
            Datetime sameDayEndDate = startDate.addDays(noOfDays);
            System.debug('Same Day : '+sameDayEndDate);
            
            Decimal hours = ((endDate.getTime())/1000/60/60) - ((sameDayEndDate.getTime())/1000/60/60);
            System.debug('hours : ' + hours); 
            
            acc.Total_Hours_Assign__c = String.valueOf(hours);
            updateTotalHoursAssign.add(acc);
        }
        if(updateTotalHoursAssign.size() > 0){
            UPDATE updateTotalHoursAssign;
        }
    }
}