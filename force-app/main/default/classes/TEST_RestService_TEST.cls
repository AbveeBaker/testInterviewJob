@isTest
public with sharing class TEST_RestService_TEST {
    
    @isTest static void executeServiceSucces(){
        String body = '[{"positive": 28756489,"negative": 74582825,"hospitalizedCurrently": 40199,"dateChecked": "2021-03-07T24:00:00Z"},{"positive": 28714654,"negative": 74450990,"hospitalizedCurrently": 41401,"dateChecked": "2021-03-06T24:00:00Z"}]';
        Integer code = 200;

        Test.setMock(HttpCalloutMock.class, new TEST_RestServiceMockGenerator(body, code));

        test.startTest();
        TEST_RestServiceCallout.executeService();
        test.stopTest();
    }

    @isTest static void executeServiceFail(){
        String body = '';
        Integer code = 0;

        Test.setMock(HttpCalloutMock.class, new TEST_RestServiceMockGenerator(body, code));

        test.startTest();
        TEST_RestServiceCallout.executeService();
        test.stopTest();
    }
}