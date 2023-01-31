public class ContactImageMapControllerBackup {
    public List<ContactModel> conModel {get;set;}
    public Integer sno=1;
    
    public ContactImageMapControllerBackup(){
        conModel = new List<ContactModel>();
        Map<Id, Contact> conMap = new Map<Id, Contact>([SELECT Id, Name FROM Contact]);
        Map<Id, Attachment> attMap = new Map<Id, Attachment>();
        //System.debug('map => ' + attMap);
        //System.debug('con => ' + conMap);
        List<Attachment> attList = [SELECT Id, parentId FROM Attachment WHERE ParentId In : conMap.keySet()];
        
        for(Attachment att : attList){
            attMap.put(att.parentId, att);
        }
        
        for(Id conKey : conMap.keySet()){
            if(attMap.containsKey(conKey)){
                conModel.add(new ContactModel(conMap.get(conKey),attMap.get(conKey),true,sno++)); 
            }else{
                conModel.add(new ContactModel(conMap.get(conKey), new Attachment(),false,sno++));
            }
        }
    }
    
    public class ContactModel{
        public Contact conObj {get;set;}
        public Attachment attObj {get;set;}
        public Boolean isImage {get;set;}
        public Integer serialNo {get;set;}
        
        public ContactModel(Contact conObj, Attachment attObj, Boolean isImage, Integer serialNo){
          
            this.conObj = conObj;
            this.attObj = attObj;
            this.isImage = isImage;
            this.serialNo = serialNo;
        }
    }
}