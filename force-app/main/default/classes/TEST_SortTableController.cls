public with sharing class TEST_SortTableController {
    @AuraEnabled(Cacheable=true)
    public static List <covid_tracking__c> getTrackingCovid() {
        System.debug('TEST_SortTableController:getTrackingCovid:INICIO');
        List<covid_tracking__c> lstTC = [ SELECT Id, Name, CreatedDate, Date_Checked__c, Positive__c, Negative__c, Hospitalized_Currently__c FROM covid_tracking__c ORDER BY Date_Checked__c DESC];
        return lstTC;
    } 

    @AuraEnabled
    public static String deleteTC(String Id) {
        String response;
        System.debug('TEST_SortTableController:deleteTC:INICIO:Id: ' + Id);
        covid_tracking__c deletedObj = new covid_tracking__c();
        deletedObj.Id = Id;
        try{
            delete deletedObj;
            response = 'EXITO';
        }catch(Exception e){
            System.debug('ERROR: ' + e.getMessage() + ', Linea: ' + e.getLineNumber() + ', StackTrace: ' + e.getStackTraceString());
            response = 'ERROR: ' + e.getMessage() + ', Linea: ' + e.getLineNumber() + ', StackTrace: ' + e.getStackTraceString();
        }
        
        return response;
    }
}