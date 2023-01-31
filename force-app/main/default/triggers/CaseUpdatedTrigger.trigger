trigger CaseUpdatedTrigger on Case (before update, before Insert) {
    
    if(Trigger.isBefore && Trigger.isInsert || Trigger.isUpdate){
        List<String> caseSubjectList = new List<String>();
        System.debug('In trigger');
        for(Case cs : Trigger.new){
            caseSubjectList.add(cs.Subject);    
        }
        System.debug('caseSubjectList ==> ' + caseSubjectList);
        
        Map<String, Case> caseSubjectId = new Map<String, Case>();
        for(Case cs : [SELECT Id, Subject FROM Case WHERE Subject IN: caseSubjectList]){
            caseSubjectId.put(cs.Subject, cs);    
        }
        System.debug('caseSubjectId ==> ' + caseSubjectId);
        
        if(caseSubjectId.size() > 0){
            for(Case cs : Trigger.new){
                if(caseSubjectId.get(cs.Subject) != null){
                    System.debug('In Errro Block');
                    cs.Subject.addError('Subject Is Duplicate');
                }
            }   
        }
    }   
}