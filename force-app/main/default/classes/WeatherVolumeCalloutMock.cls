@isTest
global class WeatherVolumeCalloutMock implements HttpCalloutMock{
    global HttpResponse respond(HTTPRequest req){
        HttpResponse res = new HttpResponse();
        res.setStatus('OK');
        res.setStatusCode(200);
        res.setBody('{"coord":{"lon":74.6333,"lat":26.45},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"base":"stations","main":{"temp":40.68,"feels_like":37.66,"temp_min":40.68,"temp_max":40.68,"pressure":998,"humidity":10,"sea_level":998,"grnd_level":947},"visibility":10000,"wind":{"speed":6.02,"deg":279,"gust":6.33},"clouds":{"all":3},"dt":1653993787,"sys":{"country":"IN","sunrise":1653955745,"sunset":1654004967},"timezone":19800,"id":1279159,"name":"Ajmer","cod":200}');
        
        return res;
    }
}