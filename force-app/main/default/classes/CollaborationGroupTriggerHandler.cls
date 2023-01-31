public class CollaborationGroupTriggerHandler {
    
    public static void handleBeforeInsert(List<CollaborationGroup> collaborationList){
        List<String> chatterGroupNames = new List<String>();
    	List<Group> createNewGroup = new List<Group>();
        for(CollaborationGroup collaboration : collaborationList){
            chatterGroupNames.add(collaboration.Name);
        }
        
        List<Group> groupList = [SELECT Id, Name FROM Group WHERE Name != null];
        for(String name : chatterGroupNames){
            for(Group groupObj : groupList){
                if(groupObj.Name != name){
                    createNewGroup.add(new Group(Name = name));    
                }    
            }
        }
        
        if(createNewGroup.size() > 0){
        	INSERT createNewGroup;  
            System.debug('createNewGroup ==> ' + createNewGroup);
        }
    }
}