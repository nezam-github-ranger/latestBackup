//Generated by wsdl2apex

public class AsyncParkServices {
    public class byCountryResponseFuture extends System.WebServiceCalloutFuture {
        public String[] getValue() {
            ParkServices.byCountryResponse response = (ParkServices.byCountryResponse)System.WebServiceCallout.endInvoke(this);
            return response.return_x;
        }
    }
    public class AsyncParksImplPort {
        public String endpoint_x = 'https://th-apex-soap-service.herokuapp.com/service/parks';
        public Map<String,String> inputHttpHeaders_x;
        public String clientCertName_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://parks.services/', 'ParkServices'};
        public AsyncParkServices.byCountryResponseFuture beginByCountry(System.Continuation continuation,String arg0) {
            ParkServices.byCountry request_x = new ParkServices.byCountry();
            request_x.arg0 = arg0;
            return (AsyncParkServices.byCountryResponseFuture) System.WebServiceCallout.beginInvoke(
              this,
              request_x,
              AsyncParkServices.byCountryResponseFuture.class,
              continuation,
              new String[]{endpoint_x,
              '',
              'http://parks.services/',
              'byCountry',
              'http://parks.services/',
              'byCountryResponse',
              'ParkServices.byCountryResponse'}
            );
        }
    }
}