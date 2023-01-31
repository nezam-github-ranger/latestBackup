public class BulkAccountContact {
    public Integer index {get; set;}
    public Integer contactRemovedIndex {get; set;} 
    public Integer srNumber;
    public List<BulkDataStore> wrapperList {get; set;}
    
    public BulkAccountContact(){
        wrapperList = new List<BulkDataStore>();
        srNumber = 0; 
        wrapperList.add(new BulkDataStore());
        wrapperList.get(0).serialNo = srNumber;
        wrapperList.get(0).accountObj = new Account();
        wrapperList.get(0).contactIndexMap = new Map<Integer, Contact>();  
        System.debug('wrapper list in constructor ==> ' + wrapperList);
    }
    
    public void newAccount(){
        wrapperList.add(new BulkDataStore());
        wrapperList.get(wrapperList.size() - 1).serialNo = ++srNumber;
        wrapperList.get(wrapperList.size() - 1).accountObj = new Account();
        wrapperList.get(wrapperList.size() - 1).contactIndexMap = new Map<Integer, Contact>();        
        
        System.debug('wrapperlist size ==> ' + wrapperList.size());
        System.debug('wrapperList in acc ==> ' + wrapperList);
    }
    
    public void newContact(){
        System.debug('index ==> ' + index);
       
        System.debug('wrapperList.size() ==> ' + wrapperList.size());
        if(wrapperList.size() >= index + 1){
        	wrapperList.get(index).contactIndexMap.put(wrapperList.get(index).contactIndexMap.size(), new Contact());
        }
        System.debug('wrapperList in new contact ==> ' + wrapperList);
    }
    
    public void removeRow(){
        System.debug('index ==> ' + index);
        
        if(index != Null && wrapperList.size() > 1){ 
            wrapperList.remove(index);	 
            for(Integer i=0; i < wrapperList.size(); i++){
            	wrapperList.get(i).serialNo = i;    
            }
            srNumber--;
        }
        System.debug('wrapper list in remove method ==> ' + wrapperList);
    }
    
    public void contactRemoveRow(){
        System.debug('wrapper list ==> ' + wrapperList);
        System.debug('index ==> ' + index);
        System.debug('contactRemovedIndex ==> ' + contactRemovedIndex);
        if(index != Null && contactRemovedIndex != Null){
            wrapperList.get(index).contactIndexMap.remove(contactRemovedIndex);
            
            System.debug('wrapper list size in class ==> ' + wrapperList.get(index).contactIndexMap.size());
            for(Integer i=0; i < wrapperList.get(index).contactIndexMap.size(); i++){
                if(!(wrapperList.get(index).contactIndexMap.containsKey(i))){
                    wrapperList.get(index).contactIndexMap.put(i,wrapperList.get(index).contactIndexMap.get(i+1));  
                    wrapperList.get(index).contactIndexMap.remove(i+1);
                }
                System.debug('contactIndexMap.size() ==> ' + wrapperList.get(index).contactIndexMap.size());
                System.debug('contactIndexMap.keySet() ==> ' + wrapperList.get(index).contactIndexMap.keySet());
            }  
        }
        System.debug('wrapper list ==> ' + wrapperList);
    } 
    
    public PageReference save(){
        System.debug('wrapper list ==> ' + wrapperList);
        List<Account> insertAccountList = new List<Account>();
        List<Contact> insertContactList = new List<Contact>();
        Integer checkSerialNumber = 0;
        
        if(wrapperList.size() > 0 && wrapperList != Null){
            System.debug('wrapper list in save ==> ' + wrapperList);
            for(BulkDataStore fetchAccount : wrapperList){
                if(fetchAccount.accountObj.Name != Null && String.isNotBlank(fetchAccount.accountObj.Name)){
                    insertAccountList.add(fetchAccount.accountObj);     
                }else{
                    ApexPages.addmessage(new ApexPages.Message(ApexPages.severity.FATAL,'Please Enter Account Name!'));
                    return Null;
                }
            }
            if(insertAccountList.size() > 0 && insertAccountList != Null){
                INSERT insertAccountList;
                System.debug('insertAccountList ==> ' + insertAccountList);
            }
            for(BulkDataStore fetchContact : wrapperList){
                checkSerialNumber++;
                if(fetchContact.serialNo == checkSerialNumber - 1){ 
                    for(Integer i = 0; i < fetchContact.contactIndexMap.size(); i++){
                        if(fetchContact.contactIndexMap.containsKey(i)){
                            if(fetchContact.contactIndexMap.get(i).LastName != Null && String.isNotBlank(fetchContact.contactIndexMap.get(i).LastName)){
                            	Contact con = fetchContact.contactIndexMap.get(i);
                                con.Email = fetchContact.contactIndexMap.get(i).FirstName + '@gmail.com';
                                con.AccountId = insertAccountList.get(checkSerialNumber - 1).Id;
                                insertContactList.add(con);    
                            }else{
                                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please Enter Contact Last Name!'));
                            	return Null;
                            } 
                        }
                    }
                }
            }
            if(insertContactList.size() > 0 && insertContactList != Null){
                INSERT insertContactList;
                System.debug('insertAccountList ==> ' + insertContactList);
                //ApexPages.addmessage(new ApexPages.Message(ApexPages.severity.CONFIRM,'Record Successfully Insert!'));
                //return Null;
            }
        }
        return new PageReference('/apex/bulk_account_contact');
        //return pg.setRedirect(true);
    }
    
    public class BulkDataStore {
        public Account accountObj {get; set;}
        public Map<Integer, Contact> contactIndexMap {get; set;}
        public Integer serialNo {get; set;}
        
        public BulkDataStore(){
            accountObj = new Account();
            contactIndexMap = new Map<Integer, Contact>();
            serialNo = 0;
        }
    }
}