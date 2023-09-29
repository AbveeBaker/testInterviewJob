@isTest
public with sharing class TEST_SortTable_TEST {
    
    @TestSetup
    static void makeData(){
        List<covid_tracking__c> lstNewRecords = new List<covid_tracking__c>();

        for(Integer i = 0; i < 10; i++){
            covid_tracking__c newObj = new covid_tracking__c();

            newObj.Date_Checked__c = System.now();
            newObj.Positive__c = i;
            newObj.Negative__c = i;
            newObj.Hospitalized_Currently__c = i;

            lstNewRecords.add(newObj);
        }

        insert lstNewRecords;
    }

    @isTest static void getTrackingCovidSuccess(){
        
        test.startTest();
        List<covid_tracking__c> lstRes = TEST_SortTableController.getTrackingCovid();
        test.stopTest();
		System.debug('lstRes.size(): ' + lstRes.size());
        Assert.areEqual(10, lstRes.size(), 'ERROR:getTrackingCovidSuccess');
    }

    @isTest static void deleteTCSuccess(){
        Id idCT = [SELECT Id From covid_tracking__c LIMIT 1].Id;
        
        test.startTest();
        String res = TEST_SortTableController.deleteTC(idCT);
        test.stopTest();
        
        Assert.areEqual('EXITO', res, 'ERROR:deleteTCSuccess');
    }

    @isTest static void deleteTCFail(){
        //Id idCT = [SELECT Id From covid_tracking__c LIMIT 1].Id;
        
        test.startTest();
        String res = TEST_SortTableController.deleteTC(null);
        test.stopTest();
        System.debug('res: ' + res);
        Assert.areNotEqual('EXITO', res, 'ERROR:deleteTCSuccess');
    }
}