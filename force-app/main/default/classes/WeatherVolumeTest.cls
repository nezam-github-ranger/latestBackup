@isTest
public class WeatherVolumeTest {

    @isTest
    static void testPostNegative() {
       
        Test.setMock(HttpCalloutMock.class, new WeatherVolumeCalloutMock());
        Map<String, Object> responseResult = WeatherVolume.fetchWeatherVolume('');
        
        
    }
}