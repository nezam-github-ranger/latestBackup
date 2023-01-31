public class CountryController1 {
    Map<String, Map<String, Set<String>>> countryMap;
    
    public String selectedCountry {get;set;}
    public List<SelectOption> countryOptions {get;set;}
   
    public String selectedState {get;set;}
    public List<SelectOption> stateOptions {get;set;}
    
    public String selectedCity{get;set;}
    public List<SelectOption> cityOptions {get;set;}
    
    List<Country__c> countryList;
 
    public CountryController1(){
    	countryMap = new Map<String, Map<String, Set<String>>>();
        loadCountries();
        fetchCountry();
    }
    
    public void loadCountries(){
        countryList = new List<Country__c>();
        
        //countryMap.put('--None--', new Map<'--None--', new Set<String>{'none'}> );
    	countryList = [SELECT Name, state__c, city__c From Country__c];
        for(Country__c country : countryList){
           	Map<String, Set<String>> stateMap = countryMap.get(country.Name.toUpperCase());
            if(stateMap == Null){
                stateMap = new Map<String,Set<String>>();
            }
            Set<String> city = stateMap.get(country.State__c.toUpperCase());
            if(city == Null){
                city = new Set<String>();
            }
            city.add(country.City__c);
            stateMap.put(country.State__c.toUpperCase(), city);
            countryMap.put(country.Name.toUpperCase(),stateMap);    
        }
    }
   
    public void fetchCountry(){	
        countryOptions = new List<SelectOption>();
        countryOptions.add(new SelectOption('', '--None--'));
        for(String countryName : countryMap.keySet()){
            countryOptions.add(new SelectOption(countryName, countryName));
        } 
    }
    public void fetchStates(){	
        stateOptions = new List<SelectOption>();
        cityOptions = new List<SelectOption>();
        stateOptions.add(new SelectOption('', '--None--'));
        if(selectedCountry != null){
            for(String state : countryMap.get(selectedCountry).keySet()){
                stateOptions.add(new SelectOption(state, state));
            }
        }    
    }
    public void fetchCities(){
        cityOptions = new List<SelectOption>();
        cityOptions.add(new SelectOption('', '--None--'));
        if(selectedState != null){
            for(String city : countryMap.get(selectedCountry).get(selectedState)){
                cityOptions.add(new SelectOption(city, city));
            }
        }
        
    }
}