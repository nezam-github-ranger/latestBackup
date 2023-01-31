public class CountryController {
    public List<SelectOption> countryOptions {get;set;}
    public String selectedCountry {get;set;}
   
    public String selectedState {get;set;}
    public List<SelectOption> stateOptions {get;set;}
    
    public String selectedCity{get;set;}
    public List<SelectOption> cityOptions {get;set;}
    
    
    //public Map<String, Map<String, List<String>>>();
    
    
    List<Country__c> countryList = [SELECT Name FROM Country__c];
    //List<Country__c> stateList = [SELECT Name, state__c FROM Country__c];
    //public Map<String, List<String>> stateMap;

    public CountryController(){
        loadCountries();
        //loadStates();
    }
    private void loadCountries(){
        countryOptions = new List<SelectOption>();
        countryOptions.add(new SelectOption('--None--', '--None--'));
        List<String> dupList = new List<String>();
        for(Country__c country : countryList){
            if(!(dupList.contains(country.Name))){
             	countryOptions.add(new SelectOption(country.Name, country.Name));  
                dupList.add(country.Name);
            }
        } 
    }
    
  	void loadStates(){
        //System.debug('Country => ' + selectedCountry);
    	/*stateMap = new Map<String, List<String>>();
        List<String> conList = new List<String>();
       
        for(Country__c country : countryList){
            for(Country__c state : stateList){
                if(country.Name == state.Name){
                    if(!conList.contains(state.State__c)){
                    	conList.add(state.state__c);
                    	break;   
                    }
                }	  
            }
            stateMap.put(country.Name, conList); 
        }*/
       	//System.debug('stateMapVal => ' + stateMap.values());
        //System.debug('stateMapKey => ' + stateMap.keySet()); 
    }
    public void fetchStates(){
     	List<Country__c> states = [SELECT state__c FROM Country__c Where Name =: selectedCountry];
        stateOptions = new List<SelectOption>();
        List<String> dupList = new List<String>();
        for(Country__c countryObj : states){
            if(!duplist.contains(countryObj.state__c)){
                stateOptions.add(new SelectOption(countryObj.state__c, countryObj.state__c));
                duplist.add(countryObj.state__c);
            }
        }
    }
    
    public void fetchCities(){
    	List<Country__c> cities = [SELECT city__c FROM Country__c WHERE state__c =: selectedState]; 
        cityOptions = new List<SelectOption>();
        for(Country__c stateObj : cities){
            cityOptions.add(new SelectOption(stateObj.city__c, stateObj.city__c));
        }
    }
}