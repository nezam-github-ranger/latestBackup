trigger DiscoveryTrigger on Discovery__c (after insert) {

    if(Trigger.isInsert && Trigger.isAfter){
        System.debug('trigger.new ==> ' + trigger.new);
        Discovery__Share disShareObj = new Discovery__Share();
        disShareObj.ParentId = Trigger.new[0].Id;
        disShareObj.UserOrGroupId = '0055g00000D92THAAZ';
        disShareObj.AccessLevel = 'edit';
        disShareObj.RowCause = 'Manual';
        //INSERT disShareObj;
        System.debug('disShareObj ==> ' + disShareObj);
        
        Database.SaveResult sr = Database.insert(disShareObj,false);
        System.debug('sr ==> ' + sr);
   
        if(sr.isSuccess()){
      		System.debug('sr.isSuccess() ==> ' + sr.isSuccess());
        }
        else {
            Database.Error err = sr.getErrors()[0];
            System.debug('err ==> ' + err);
        }
        
        /*List<Discovery__c> disList = new List<Discovery__c>();
        for(Id id: trigger.newMap.keyset()){
            Discovery__c disObj = new Discovery__c();
            disObj.Id = id;
            disObj.Name=trigger.newMap.get(id).Name+'Update By After Trigger1';
            disList.add(disObj);
        }    
        Update disList;
        System.debug('disList ==> ' + disList);
        */
        
        
    }
}