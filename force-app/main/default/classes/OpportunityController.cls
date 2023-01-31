public class OpportunityController {
    public List<OpportunityModel> modelList {get;set;}
    
    public OpportunityController(){
        modelList = new List<OpportunityModel>();
        List<AggregateResult> aggregateResultList  = [SELECT StageName, MAX(Amount) maxAmount, SUM(Amount) sumAmount, MIN(Amount) minAmount, AVG(Amount) avgAmount, COUNT(Amount) countAmount FROM Opportunity GROUP BY StageName]; 
        
        for(AggregateResult ar : aggregateResultList){
      		modelList.add(new OpportunityModel((String)ar.get('StageName'), (Decimal)ar.get('maxAmount'), (Decimal)ar.get('sumAmount'), (Decimal)ar.get('minAmount'), (Decimal)ar.get('avgAmount'), (Integer)ar.get('countAmount')));            	 
        }
    }
   
    public class OpportunityModel{
        public String stageName  {get;set;}
        public Decimal maxAmount {get;set;}
        public Decimal sumAmount {get;set;}
        public Decimal minAmount {get;set;}
        public Decimal avgAmount {get;set;}
        public Integer countAmount {get;set;}
        
        public OpportunityModel(String stageName, Decimal maxAmount, Decimal sumAmount, Decimal minAmount, Decimal avgAmount, Integer countAmount){
        	this.stageName = stageName;
            this.maxAmount = maxAmount;
            this.sumAmount = sumAmount;
            this.minAmount = minAmount;
            this.avgAmount = avgAmount;
            this.countAmount = countAmount;
        }
    }
}