//
//  ToiletRequestTest.swift
//  WhereAreMyToiletsTests
//
//  Created by Quentin Richard on 16/12/2023.
//

import XCTest
@testable import WhereAreMyToilets

final class ToiletRequestTest: XCTestCase {
    override func tearDown() {
        super.tearDown()
        URLProtocolMock.error = nil
        URLProtocolMock.requestHandler = nil
    }
    
    func testRequestSucced() {
        // GIVEN
        let expectedUrl = "https://data.ratp.fr/api/records/1.0/search/?dataset=sanisettesparis2011&start=0&rows=100"
        let expectation = expectation(description: "Should get a success for getToilet")
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        URLProtocolMock.requestHandler = { request in
            guard let url = request.url, url.absoluteString == expectedUrl else {
                throw ToiletRequestError.invalidUrl
            }
            
            guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
                throw ToiletRequestError.unknown
            }
            return (response, Data())
        }
        let mockUrlSession = URLSession(configuration: config)
        let sut = ToiletRequest(urlSession: mockUrlSession)
        // WHEN
        
        sut.getToilet(start: "0",
                      handler: { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("We should not failed here")
            }
        })
        // THEN
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testRequestFailed() {
        // GIVEN
        let expectation = expectation(description: "Should get a failure for getToilet")
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        URLProtocolMock.error = ToiletRequestError.unknown
        let mockUrlSession = URLSession(configuration: config)
        let sut = ToiletRequest(urlSession: mockUrlSession)
        // WHEN
        
        sut.getToilet(start: "0",
                      handler: { result in
            switch result {
            case .success:
                XCTFail("We should not failed here")
            case .failure:
                expectation.fulfill()
            }
        })
        // THEN
        wait(for: [expectation], timeout: 0.1)
    }

}

private final class URLProtocolMock: URLProtocol {
    static var error: Error?
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let error = URLProtocolMock.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }
        
        guard let handler = URLProtocolMock.requestHandler else {
            assertionFailure("Received unexpected request with no handler set")
            return
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }    }
    
    override func stopLoading() { }
}

