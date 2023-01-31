public class ImportDataFromCSVController1 {
    public Blob csvFileBody{get;set;}
    public string csvAsString{get;set;}
    public String[] csvFileLines{get;set;}
    //public Set<Id> accIds;
    Map<Id, List<ObjectTerritory2Association>> accountIdTerritoryIdMap;
    Map<Id, String> accountIdTerritoryNameMap;
    List<ObjectTerritory2Association> territory2ListToCreate;
    List<ObjectTerritory2Association> territory2ListToDelete;
    Map<String, Id> territory2Map;
   
    public ImportDataFromCSVController1(){
        csvFileLines = new String[]{};
        //accIds = new Set<Id>();
        accountIdTerritoryIdMap = new Map<Id, List<ObjectTerritory2Association>>();
        accountIdTerritoryNameMap = new Map<Id, String>();
        territory2ListToCreate = new List<ObjectTerritory2Association>();
        territory2ListToDelete = new List<ObjectTerritory2Association>();
        territory2Map = new Map<String, Id>();
        for(Territory2 obj : [SELECT Id, Name FROM Territory2]){
            territory2Map.put(obj.Name, obj.Id);
        }
    }
   
    public void importCSVFile(){
        try{
            csvAsString = csvFileBody.toString();
            csvFileLines = csvAsString.split('\n');
           
            for(Integer i=1; i<csvFileLines.size(); i++){
                string[] csvRecordData = csvFileLines[i].split(',');
                //accIds.add(csvRecordData[0]);
                accountIdTerritoryNameMap.put(csvRecordData[0], csvRecordData[10]);                
            }
            System.debug('accountIdTerritoryNameMap.keySet() ==> ' + accountIdTerritoryNameMap.keySet());
            System.debug('accountIdTerritoryNameMap.values() ==> ' + accountIdTerritoryNameMap.values());
            //System.debug('accIds ==> ' + accIds);
        	
        	for(ObjectTerritory2Association territory : [SELECT Id, ObjectId, Territory2Id, Territory2.Name FROM ObjectTerritory2Association WHERE ObjectId IN: accountIdTerritoryNameMap.keySet()]){
                if(accountIdTerritoryIdMap.containsKey(territory.ObjectId)){
                    accountIdTerritoryIdMap.get(territory.ObjectId).add(territory);
                }else{
                    if(territory.ObjectId != null){
                        accountIdTerritoryIdMap.put(territory.ObjectId, new List<ObjectTerritory2Association>{territory});
                    }
                }                    
            }
            
            for(Id keys : accountIdTerritoryNameMap.keySet()){
                if(!accountIdTerritoryIdMap.containsKey(keys)){
                	    
                }   
            }
            
            System.debug('accountIdTerritoryIdMap.values() ==> ' + accountIdTerritoryIdMap.values());
            System.debug('accountIdTerritoryIdMap.keySet() ==> ' + accountIdTerritoryIdMap.keySet());
            
            for(Id accId : accountIdTerritoryNameMap.keySet()){
                if(accountIdTerritoryIdMap.containsKey(accId)){
                    Integer i = accountIdTerritoryIdMap.get(accId).size();
                    for(ObjectTerritory2Association objTerritory : accountIdTerritoryIdMap.get(accId)){
                        if(accountIdTerritoryNameMap.get(accId) != objTerritory.Territory2.Name){
                        	territory2ListToDelete.add(new ObjectTerritory2Association(Id = objTerritory.Id));
                            if(i == 0){
                            	territory2ListToCreate.add(new ObjectTerritory2Association(ObjectId = accId, Territory2Id = territory2Map.get(accountIdTerritoryNameMap.get(accId)), AssociationCause = 'Territory2Manual'));    
                            }
                        }    
                    }   
                }else{
                    territory2ListToCreate.add(new ObjectTerritory2Association(ObjectId = accId, Territory2Id = territory2Map.get(accountIdTerritoryNameMap.get(accId)), AssociationCause = 'Territory2Manual'));	
                }
            }
            
            System.debug('territory2ListToDelete ==> ' + territory2ListToDelete);
            System.debug('territory2ListToCreate ==> ' + territory2ListToCreate);
           
            DELETE territory2ListToDelete;
            INSERT territory2ListToCreate;
                       
        }catch (Exception e){
            ApexPages.Message errorMessage = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while importin data Please make sure input csv file is correct');
            ApexPages.addMessage(errorMessage);
        }  
    }
}