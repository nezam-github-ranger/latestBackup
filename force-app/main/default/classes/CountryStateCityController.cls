public class CountryStateCityController {
    public Country__c countryObj {get;set;}
    public List<CountryStateCityModel> countryList {get;set;}
    public Integer srNo = 1;
    public Boolean hide {get;set;}
    public Boolean editHide {get;set;}
    public Integer editNo {get;set;}
    public Boolean checkAll {get;set;}
    public List<CountryStateCityModel> tempList {get;set;}
    
    public CountryStateCityController(){
        editNo = 0;
        countryObj = new Country__c();
        countryList = new List<CountryStateCityModel>();
        hide = false; 
        editHide = true;
    }
    public void save(){
    	hide = true;
        System.debug('edit no ==> ' + editNo);
        editNo = countryList.size() > 0 ? editNo : 0;
        if(editNo == 0){
            countryList.add(new CountryStateCityModel(countryObj, srNo++));
        }else{
            for(CountryStateCityModel con : countryList){
                if(con.serialNo == editNo){
                	con.detailsObj.Name = countryObj.Name;
                    con.detailsObj.State__c = countryObj.State__c;
                    con.detailsObj.City__c = countryObj.City__c;
                }	    
            }
            editNo = 0;
        } 
        countryObj = new Country__c();
    }
    public void editClicked(){
        if(countryList.size() > 0){
            for(CountryStateCityModel con : countryList){
                if(con.serialNo == editNo){
                    countryObj.Name = con.detailsObj.Name;
                    countryObj.State__c = con.detailsObj.State__c;
                    countryObj.City__c = con.detailsObj.City__c;
                }	
            }
        }
    }
    public void deleteClicked(){
        if(countryList.size() > 0){
            for(Integer i=0; i<countryList.size(); i++){
                CountryStateCityModel con = countryList.get(i);
                if(con.serialNo == editNo){
                    countryList.remove(countryList.indexOf(con));
                    countryObj.Name = '';
                    countryObj.State__c = '';
                    countryObj.City__c = '';
                }   
            } 
        }
    }
    public void checkboxSelect(){
        Boolean check = false;
        for(CountryStateCityModel con : countryList){
            if(con.checkbox == false){
             	check = false;   
            }
        } 
        checkAll = check;
    }
    public void checkboxAllSelect(){
        if(checkAll){
            for(CountryStateCityModel con : countryList){
                con.checkbox = checkAll;
            }
        }else{
         	for(CountryStateCityModel con : countryList){
                con.checkbox = checkAll;
            }   
        }
    }
    public void multipleEdit(){
        editHide = false;
        tempList = new list<CountryStateCityModel>();
        for(CountryStateCityModel con : countryList){
            if(con.checkbox){
                tempList.add(con); 
            }
        }
    }
    public void multipleDelete(){
        for(Integer i=countryList.size() - 1; i>=0; i--){
            CountryStateCityModel con = countryList.get(i);
            if(con.checkbox){
            	countryList.remove(i);		    
            }
        }   
    }
    public void editSave(){
        editHide = true;
        Integer j=0;
        for(Integer i=0; i<countryList.size(); i++){
            CountryStateCityModel con = countryList.get(i);
            CountryStateCityModel temp = tempList.get(j);
            if(con.serialNo == temp.serialNo){
                con.detailsObj.Name = temp.detailsObj.Name;
                con.detailsObj.State__c = temp.detailsObj.State__c;
                con.detailsObj.City__c = temp.detailsObj.City__c;
                j++;
            }
            con.checkbox = false;
        }
    }
    public PageReference submitRecord(){
        List<Country__c> insertList = new List<Country__c>();
        for(CountryStateCityModel com : countryList){
        	insertList.add(com.detailsObj);    
        }
        Upsert insertList;
        
        PageReference pg = new PageReference('/Apex/CountryStateCityPage');
        pg.setRedirect(true);
        return pg;
    }
    public class CountryStateCityModel {
        public Country__c detailsObj {get;set;}
        public Integer serialNo {get;set;}
        public Boolean checkbox {get;set;}
        
        public CountryStateCityModel(Country__c detailsObj, Integer serialNo){
            this.detailsObj = detailsObj;
            this.serialNo = serialNo;
        }
    }
}