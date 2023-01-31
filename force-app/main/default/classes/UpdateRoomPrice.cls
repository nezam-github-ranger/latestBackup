global class UpdateRoomPrice implements Database.Batchable<sObject>,Database.Stateful, Schedulable {
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, Price__c FROM Room__c]);
    }
    
    global void execute(Database.BatchableContext bc , List<Room__c> roomList){
        for(Room__c room : roomList){
            if(room.Price__c < 8000){
            	room.Price__c = room.Price__c + 2000;    
            }
        }        
        upsert roomList;
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Update Successfullyyyyyyy ');
        List<String> senderEmailList = new List<String>();
        senderEmailList.add('nezam21nex@gmail.com');
        
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage sem = new Messaging.SingleEmailMessage();
        
        sem.setToAddresses(senderEmailList);
        sem.setSubject('Room Price Updated by 200 Ruppess');
        sem.setPlainTextBody('Room Price Updated Successfully....!!!');
        emailMessages.add(sem);
        Messaging.sendEmail(emailMessages);
    }
    global void execute(SchedulableContext sc){
    	UpdateRoomPrice urp = new UpdateRoomPrice();
        Database.executeBatch(urp);
    }
}