public class OpportunityLineItemTriggerHandler {
    
    public static void handleOnInsert(List<OpportunityLineItem> listOfLineItem){
        Map<Id, List<OpportunityLineItem>> productIdAndLineItemMap = new Map<Id, List<OpportunityLineItem>>();
        List<Product2> updateProductList = new List<Product2>();
        for(OpportunityLineItem lineItemObj : listOfLineItem){
            if(productIdAndLineItemMap.containsKey(lineItemObj.Product2Id)){
                productIdAndLineItemMap.get(lineItemObj.Product2Id).add(lineItemObj);	    
            }else{
                productIdAndLineItemMap.put(lineItemObj.Product2Id, new List<OpportunityLineItem>{lineItemObj});    
            }
        }  
        System.debug('productIdAndLineItemMap => ' + productIdAndLineItemMap);
        if(productIdAndLineItemMap.size() > 0 && productIdAndLineItemMap != Null){
            for(Product2 product : [SELECT Id, Quantity__c, Quantity_Available__c, Quantity_Used__c FROM Product2 WHERE Id IN: productIdAndLineItemMap.keySet()]){
                product.Quantity__c = product.Quantity__c == Null ? '0' : product.Quantity__c;
                product.Quantity_Used__c = product.Quantity_Used__c == Null ? '0' : product.Quantity_Used__c; 
                product.Quantity_Available__c = product.Quantity_Available__c == Null ? '0' : product.Quantity_Available__c; 
                
                //Product Id , 18
                
                for(OpportunityLineItem lineItem : productIdAndLineItemMap.get(product.Id)){
                    if(lineItem.Quantity < Decimal.valueOf(product.Quantity_Available__c)){
                        product.Quantity_Used__c = String.valueOf(Decimal.valueOf(product.Quantity_Used__c) + lineItem.Quantity);	
                        product.Quantity_Available__c = String.valueOf(Decimal.valueOf(product.Quantity__c) - Decimal.valueOf(product.Quantity_Used__c));
                        updateProductList.add(product);
                    }
                    else{
                        lineItem.Quantity.addError('This Product have no available quantity!');
                    }
                }
            } 
            System.debug('updateProductList ==> ' + updateProductList);
            if(updateProductList.size() > 0 && updateProductList != Null){
                UPDATE updateProductList;
            }
        }
    }
    
    public static void handleOnUpdate(Map<Id, OpportunityLineItem> newValuesMap, Map<Id, OpportunityLineItem> oldValuesMap){
        Map<Id, List<OpportunityLineItem>> productIdAndLineItemMap = new Map<Id, List<OpportunityLineItem>>();
        List<Product2> updateProductList = new List<Product2>();
        for(OpportunityLineItem lineItemObj : newValuesMap.values()){
            if(lineItemObj.Quantity != oldValuesMap.get(lineItemObj.Id).Quantity){
                if(productIdAndLineItemMap.containsKey(lineItemObj.Product2Id)){
                    productIdAndLineItemMap.get(lineItemObj.Product2Id).add(lineItemObj);	    
                }else{
                    productIdAndLineItemMap.put(lineItemObj.Product2Id, new List<OpportunityLineItem>{lineItemObj});    
                }
            }    
        }
        if(productIdAndLineItemMap.size() > 0 && productIdAndLineItemMap != Null){
            for(Product2 product : [SELECT Id, Quantity__c, Quantity_Available__c, Quantity_Used__c FROM Product2 WHERE Id IN: productIdAndLineItemMap.keySet()]){ 
                
                for(OpportunityLineItem lineItem : productIdAndLineItemMap.get(product.Id)){
                    if(lineItem.Quantity < Decimal.valueOf(product.Quantity__c)){
                        if(oldValuesMap.get(lineItem.Id).Quantity != lineItem.Quantity){
                            lineItem.Quantity = lineItem.Quantity - oldValuesMap.get(lineItem.Id).Quantity;	    
                        }
                        product.Quantity_Used__c = String.valueOf(Decimal.valueOf(product.Quantity_Used__c) + lineItem.Quantity);	
                        product.Quantity_Available__c = String.valueOf(Decimal.valueOf(product.Quantity__c) - Decimal.valueOf(product.Quantity_Used__c));
                        updateProductList.add(product);
                    }
                    else{
                        lineItem.addError('This Product have no available quantity!');
                    }
                }
            }
        }
        System.debug('updateProductList ==> ' + updateProductList);
        if(updateProductList.size() > 0 && updateProductList != Null){
            UPDATE updateProductList;
        }
    }
    
    public static void handleOnDelete(List<OpportunityLineItem> listOfLineItem){
        System.debug('listOfLineItem ==> ' + listOfLineItem);
        Map<Id, List<OpportunityLineItem>> productIdAndLineItemMap = new Map<Id, List<OpportunityLineItem>>();
        List<Product2> updateProductList = new List<Product2>();
        for(OpportunityLineItem lineItemObj : listOfLineItem){
            if(productIdAndLineItemMap.containsKey(lineItemObj.Product2Id)){
                productIdAndLineItemMap.get(lineItemObj.Product2Id).add(lineItemObj);	    
            }else{
                productIdAndLineItemMap.put(lineItemObj.Product2Id, new List<OpportunityLineItem>{lineItemObj});    
            }
        }
        if(productIdAndLineItemMap.size() > 0 && productIdAndLineItemMap != Null){
            for(Product2 product : [SELECT Id, Quantity__c, Quantity_Available__c, Quantity_Used__c FROM Product2 WHERE Id IN: productIdAndLineItemMap.keySet()]){ 
                
                for(OpportunityLineItem lineItem : productIdAndLineItemMap.get(product.Id)){
                    product.Quantity_Used__c = String.valueOf(Decimal.valueOf(product.Quantity_Used__c) - lineItem.Quantity);	
                    product.Quantity_Available__c = String.valueOf(Decimal.valueOf(product.Quantity__c) - Decimal.valueOf(product.Quantity_Used__c));
                    updateProductList.add(product);
                }
            }
        }
        System.debug('updateProductList ==> ' + updateProductList);
        if(updateProductList.size() > 0 && updateProductList != Null){
            UPDATE updateProductList;
        }
    }
}