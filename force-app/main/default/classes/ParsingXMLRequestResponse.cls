public class ParsingXMLRequestResponse {
    private static Dom.XmlNode resultNode;
    
    public ParsingXMLRequestResponse(){
        String reqResponse = '';
        reqResponse += '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">';
        reqResponse += '<soap:Body>';
        reqResponse += '<grexxResponse xmlns="http://schemas.grexx.net/atalanta/connect">';
        reqResponse += '<header>';
        reqResponse += '<transactionID>1:5490:81587266</transactionID>';
        reqResponse += '<reference>?</reference>';
        reqResponse += '</header>';
        reqResponse += '<status>';
        reqResponse += '<code>0</code>';
        reqResponse += '<message>Succes</message>';
        reqResponse += '</status>';
        reqResponse += '<responseData>';
        reqResponse += '<OrderSummaryResponse_V1>';
        reqResponse += '<Status>';
        reqResponse += '<Messages/>';
        reqResponse += '<Code>Success</Code>';
        reqResponse += '</Status>';
        reqResponse += '<PagedResult>';
        reqResponse += '<Skip>0</Skip>';
        reqResponse += '<Take>2500</Take>';
        reqResponse += '<TotalNumberOfRecords>3</TotalNumberOfRecords>';
        reqResponse += '<Results>';
        
        reqResponse += '<OrderSummary_V1>';
        reqResponse += '<OrderId>7626815</OrderId>';
        reqResponse += '<ReferenceOrderId p5:nil="true" xmlns:p5="http://www.w3.org/2001/XMLSchema-instance"/>';
        reqResponse += '<ParentId p5:nil="true" xmlns:p5="http://www.w3.org/2001/XMLSchema-instance"/>';
        reqResponse += '<CustomerId>271860</CustomerId>';
        reqResponse += '<ProductId>RO000O993</ProductId>';
        reqResponse += '<ProductName>Inschrijving | HIP Expert</ProductName>';
        reqResponse += '<ProductGroup>Additional</ProductGroup>';
        reqResponse += '<ProductCommercialTypeName>Events</ProductCommercialTypeName>';
        reqResponse += '<DateCreated>2020-12-04T13:54:44.803</DateCreated>';
        reqResponse += '<DateActive>2021-02-01T10:33:32.147</DateActive>';
        reqResponse += '<DateModified>2021-02-01T10:33:32.147</DateModified>';
        reqResponse += '<DateTerminate p5:nil="true" xmlns:p5="http://www.w3.org/2001/XMLSchema-instance"/>';
        reqResponse += '<DateTerminated p5:nil="true" xmlns:p5="http://www.w3.org/2001/XMLSchema-instance"/>';
        reqResponse += '<Label>Erik Dunning</Label>';
        reqResponse += '<OrderState>Invoicing</OrderState>';
        reqResponse += '<Quantity>1</Quantity>';
        reqResponse += '<ServiceLevelAgreement>BestEffort</ServiceLevelAgreement>';
        reqResponse += '</OrderSummary_V1>';
        
        reqResponse += '<OrderSummary_V1>';
        reqResponse += '<OrderId>7850366</OrderId>';
        reqResponse += '<ReferenceOrderId>7726298</ReferenceOrderId>';
        reqResponse += '<ParentId p5:nil="true" xmlns:p5="http://www.w3.org/2001/XMLSchema-instance"/>';
        reqResponse += '<CustomerId>271860</CustomerId>';
        reqResponse += '<ProductId>120A00027B</ProductId>';
        reqResponse += '<ProductName>Microsoft 365 Business Premium</ProductName>';
        reqResponse += '<ProductGroup>Voip</ProductGroup>';
        reqResponse += '<ProductCommercialTypeName>Microsoft 365</ProductCommercialTypeName>';
        reqResponse += '<DateCreated>2021-01-04T09:09:06.8</DateCreated>';
        reqResponse += '<DateActive>2021-01-04T09:15:39.153</DateActive>';
        reqResponse += '<DateModified>2021-01-28T09:21:40.6</DateModified>';
        reqResponse += '<DateTerminate>2021-01-28T00:00:00</DateTerminate>';
        reqResponse += '<DateTerminated>2021-01-28T09:21:40.6</DateTerminated>';
        reqResponse += '<OrderState>Terminated</OrderState>';
        reqResponse += '<Quantity>12</Quantity>';
        reqResponse += '<ServiceLevelAgreement>NextBusinessDay</ServiceLevelAgreement>';
        reqResponse += '</OrderSummary_V1>';
        
        reqResponse += '<OrderSummary_V1>';
        reqResponse += '<OrderId>7984687</OrderId>';
        reqResponse += '<ReferenceOrderId>7850366</ReferenceOrderId>';
        reqResponse += '<ParentId p5:nil="true" xmlns:p5="http://www.w3.org/2001/XMLSchema-instance"/>';
        reqResponse += '<CustomerId>271860</CustomerId>';
        reqResponse += '<ProductId>120A00027C</ProductId>';
        reqResponse += '<ProductName>Microsoft 366 Business Premium</ProductName>';
        reqResponse += '<ProductGroup>Mobile</ProductGroup>';
        reqResponse += '<ProductCommercialTypeName>Microsoft 365</ProductCommercialTypeName>';
        reqResponse += '<DateCreated>2021-01-28T09:15:50.677</DateCreated>';
        reqResponse += '<DateActive>2021-01-28T09:21:40.6</DateActive>';
        reqResponse += '<DateModified>2021-01-28T09:21:40.6</DateModified>';
        reqResponse += '<DateTerminate p5:nil="true" xmlns:p5="http://www.w3.org/2001/XMLSchema-instance"/>';
        reqResponse += '<DateTerminated p5:nil="true" xmlns:p5="http://www.w3.org/2001/XMLSchema-instance"/>';
        reqResponse += '<OrderState>Active</OrderState>';
        reqResponse += '<Quantity>13</Quantity>';
        reqResponse += '<ServiceLevelAgreement>NextBusinessDay</ServiceLevelAgreement>';
        reqResponse += '</OrderSummary_V1>';
        
        reqResponse += '</Results>';
        reqResponse += '</PagedResult>';
        reqResponse += '</OrderSummaryResponse_V1>';
        reqResponse += '</responseData>';
        reqResponse += '</grexxResponse>';
        reqResponse += '</soap:Body>';
        reqResponse += '</soap:Envelope>'; 
        
        System.debug('reqResponse  ==> ' + reqResponse);
        
        if(String.isNotBlank(reqResponse)){
            Dom.Document doc = new Dom.Document();
            try{
                doc.load(reqResponse);
            }catch(Exception ee){
                system.debug(ee.getMessage());
            }
            if(doc.getRootElement() != NULL){
                Dom.XmlNode root = doc.getRootElement();
                getResult(root);
                Set<String> productIds = new Set<String>();
                Set<String> irmaIds = new Set<String>();
                List<CustomerOrder> customerOrders = new List<CustomerOrder>();
                for(Dom.XmlNode node : resultNode.getChildElements()) {
                    CustomerOrder objCustomerOrder = parseXML(node);
                    customerOrders.add(objCustomerOrder);
                } 
                System.debug('customerOrders list ==> ' + customerOrders);
            }
        }
    } 
    
    private static void getResult(DOM.XMLNode node) {
        for(Dom.XMLNode child: node.getChildElements()) {
            if(child.getName().equalsIgnoreCase('Results')) {
                resultNode = child;
            } else {
                getResult(child);
            }
        }
        System.debug('result node ==> ' + resultNode);
    }
    
    private static CustomerOrder parseXML(DOM.XMLNode node) {
        
        CustomerOrder objCustomerOrder = new CustomerOrder();
        
        for(Dom.XmlNode childNodes : node.getChildElements()){
            String childNodeName = childNodes.getName();
            String value = childNodes.getText();
            
            if(childNodeName.equalsIgnoreCase('OrderId')){
                objCustomerOrder.orderId = value;
            } else if(childNodeName.equalsIgnoreCase('ProductId')){
                objCustomerOrder.productId = value;
            } else if(childNodeName.equalsIgnoreCase('DateCreated') && String.isNotBlank(value)){
                objCustomerOrder.dateCreated = value;//datetime.valueOf(value.replace('T',' '));
            } else if(childNodeName.equalsIgnoreCase('DateActive') && String.isNotBlank(value)){
                objCustomerOrder.dateActive = value;//datetime.valueOf(value.replace('T',' '));
            } else if(childNodeName.equalsIgnoreCase('DateModified') && String.isNotBlank(value)){
                objCustomerOrder.dateModified = value;//datetime.valueOf(value.replace('T',' '));
            } else if(childNodeName.equalsIgnoreCase('Label')){
                objCustomerOrder.label = value;
            } else if(childNodeName.equalsIgnoreCase('OrderState')){
                objCustomerOrder.orderState = value;
            } else if(childNodeName.equalsIgnoreCase('Quantity') && String.isNotBlank(value)){
                objCustomerOrder.quantity = value;//Decimal.valueOf(value);
            } else if(childNodeName.equalsIgnoreCase('Attribute')) {
                objCustomerOrder.phoneNumber = value;
            } else if(childNodeName.equalsIgnoreCase('ProductGroup')) {
                objCustomerOrder.productGroup = value;
            } else if(childNodeName.equalsIgnoreCase('CustomerId')) {
                objCustomerOrder.customerId = value;
            }
        }
        
        return objCustomerOrder;
    }
    
    public class CustomerOrder {
        public String orderId;
        public String customerId;
        public String productId;
        public String productName;
        public String productGroup;
        public String productCommercialTypeName;
        public String dateCreated;
        public String dateActive;
        public String dateModified;
        public String label;
        public String orderState;
        public String quantity;
        public String phoneNumber;
        
    }    
}