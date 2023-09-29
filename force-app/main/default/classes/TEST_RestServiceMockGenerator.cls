global with sharing class TEST_RestServiceMockGenerator implements HttpCalloutMock{

    String body = '';
    Integer code = 200;

    global TEST_RestServiceMockGenerator(String body, Integer code) {
        this.body = body;
        this.code = code;
    }

    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setBody(this.body);
        response.setStatusCode(this.code);
        return response; 
    }
}