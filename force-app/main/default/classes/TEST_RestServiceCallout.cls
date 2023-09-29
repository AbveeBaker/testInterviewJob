public with sharing class TEST_RestServiceCallout {
    

    public static void executeService(){
        List<WrapperResponse> lstResponse = new List<WrapperResponse>();

        try{
            Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:TestRestService');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if(response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug('EXITO');
            System.debug(response.getBody());

            lstResponse = (List<WrapperResponse>) JSON.deserialize(response.getBody(), List<WrapperResponse>.Class);
            
            TEST_RestServiceCallout.saveData(lstResponse);
        }
        }catch(Exception e){
            System.debug('ERROR: ' + e.getMessage() + ', Linea: ' + e.getLineNumber() + ', StackTrace: ' + e.getStackTraceString());
        }

        
    }

    public class WrapperResponse{
        public String dateChecked {get;set;}
        public Integer positive {get;set;}
        public Integer negative {get;set;}
        public Integer hospitalizedCurrently {get;set;}
    }

    public static void saveData(List<WrapperResponse> lstRecords){
        System.debug('TEST_RestServiceCallout:saveData:INICIO');
        List<covid_tracking__c> lstNewRecords = new List<covid_tracking__c>();

        for(WrapperResponse currentRecord : lstRecords){
            covid_tracking__c newObj = new covid_tracking__c();

            currentRecord.dateChecked = currentRecord.dateChecked.replace('T', ' ');
            currentRecord.dateChecked = currentRecord.dateChecked.replace('Z', '');

            newObj.Date_Checked__c = Datetime.valueOf(currentRecord.dateChecked);
            newObj.Positive__c = currentRecord.positive;
            newObj.Negative__c = currentRecord.negative;
            newObj.Hospitalized_Currently__c = currentRecord.hospitalizedCurrently;

            lstNewRecords.add(newObj);
        }

        insert lstNewRecords;

    }

}