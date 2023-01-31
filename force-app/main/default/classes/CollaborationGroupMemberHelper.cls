public class CollaborationGroupMemberHelper {
    
    public static List<GroupMember> groupMemberList = new List<GroupMember>();
    public static Map<String, Set<String>> chatterGroupNames = new Map<String, Set<String>>();
    public static List<String> createdGroupName = new List<String>();
    public static List<Group> createNewGroup = new List<Group>();
    
	
    @future
    public static void handleAfterInsert(Set<Id> collaborationGroupMemberList){
        System.debug('collaborationGroupMemberList ==> ' + collaborationGroupMemberList);
        
        for(CollaborationGroupMember collaboration :  [SELECT ID ,CollaborationGroup.Name, CollaborationGroup.CollaborationType, MemberId FROM CollaborationGroupMember WHERE ID IN :  collaborationGroupMemberList]){
            if(chatterGroupNames.containsKey(collaboration.CollaborationGroup.Name)){
            	chatterGroupNames.get(collaboration.CollaborationGroup.Name).add(collaboration.MemberId);	   
            }else{
                chatterGroupNames.put(collaboration.CollaborationGroup.Name, new Set<String>());
                chatterGroupNames.get(collaboration.CollaborationGroup.Name).add(collaboration.MemberId);
            }            
        }
        System.debug('chatterGroupNames ==> ' + chatterGroupNames);
        
        Map<String, List<String>> availableGroups = new Map<String, List<String>>();
        for(Group groupObj : [SELECT Id, Name FROM Group WHERE Name IN: chatterGroupNames.keySet()]){
            if(chatterGroupNames.containsKey(groupObj.Name)){
                createdGroupName.add(groupObj.Name);
                availableGroups.put(groupObj.Id, new List<String>());
                availableGroups.get(groupObj.Id).addAll(chatterGroupNames.get(groupObj.Name));
            }	
        }
        
        for(String chatterName : chatterGroupNames.keySet()){
            if(createdGroupName.size() > 0){
                for(String createdGroup : createdGroupName){
                    if(chatterName != createdGroup){
                        createNewGroup.add(new Group(Name = chatterName, Type = 'Regular'));	
                    }    
                }    
            }else{
            	createNewGroup.add(new Group(Name = chatterName, Type = 'Regular'));	   
            }
        }
        
        System.debug('createNewGroup **'+createNewGroup);
        if(createNewGroup.size() > 0){
            try{
            	INSERT createNewGroup;   
            }catch(Exception ex){
                for(Group groupObj : createNewGroup){
                    groupObj.addError('Error in creating Group object record : ' +  ex.getMessage()); 
                }		   
            }
            
            groupMemberList = new List<GroupMember>();
            for(Group groupObj : createNewGroup){
                for(String userOrGroupId : chatterGroupNames.get(groupObj.Name)){
                	groupMemberList.add(new GroupMember(UserOrGroupId = userOrGroupId, GroupId = groupObj.Id));	       
                }
            }
            System.debug('groupMemberList **'+groupMemberList);
            if(groupMemberList.size() > 0){
                try{
                    INSERT groupMemberList;   
                }catch(Exception ex){
                    for(GroupMember memberObj : groupMemberList){
                        memberObj.addError('Error in creating GroupMember object record : ' +  ex.getMessage()); 
                    }		   
                }
            }  
        } 
        
        System.debug('availableGroups ==> ' + availableGroups);
        groupMemberList = new List<GroupMember>();
        for(String groupId : availableGroups.keySet()){
            for(String userOrGroupId : availableGroups.get(groupId)){
            	groupMemberList.add(new GroupMember(UserOrGroupId = userOrGroupId, GroupId = groupId));    
            }
        }
        
        System.debug('groupMemberList **'+groupMemberList);
        if(groupMemberList.size() > 0){
            try{
                INSERT groupMemberList;   
            }catch(Exception ex){
                for(GroupMember memberObj : groupMemberList){
                    memberObj.addError('Error in creating GroupMember object record : ' +  ex.getMessage()); 
                }		   
            }
        }  
        
        
    }
	
    public static void handleAfterDelete(List<CollaborationGroupMember> collaborationGroupMemberList){
        List<String> memberList = new List<String>();
        List<String> userOrGroupIdList = new List<String>();
        for(CollaborationGroupMember collaboration : collaborationGroupMemberList){
       		memberList.add(collaboration.MemberId);
            userOrGroupIdList.add(collaboration.CollaborationGroupId);
        } 
        
        Set<String> collaborationGroupName = new Set<String>();
        for(CollaborationGroup collaborationGroupObj: [SELECT Id, Name FROM CollaborationGroup WHERE Id IN: userOrGroupIdList]){
        	collaborationGroupName.add(collaborationGroupObj.Name);    
        }
        
        System.debug('collaborationGroupName ==> ' + collaborationGroupName);
        if(collaborationGroupName.size() > 0){
        	deleteGroupMember(collaborationGroupName, memberList);    
        }
    }
    
    @future
    public static void deleteGroupMember(Set<String> collaborationGroupName, List<String> memberList){
     
        groupMemberList = [SELECT Id, GroupId, Group.Name, UserOrGroupId FROM GroupMember WHERE UserOrGroupId IN: memberList AND Group.Name IN: collaborationGroupName];
        System.debug('groupMemberList  in delete==> ' + groupMemberList);
        if(groupMemberList.size() > 0){
            try{
                DELETE groupMemberList;   
            }catch(Exception ex){
                for(GroupMember memberObj : groupMemberList){
                    memberObj.addError('Error in deleting GroupMember object record : ' +  ex.getMessage()); 
                }		   
            }
        	    
        }
    }
}