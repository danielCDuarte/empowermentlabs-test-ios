//
//  NetworkServiceTest.swift
//  empowermentLabsTests
//
//  Created by Daniel Crespo Duarte on 26/01/23.
//

import Combine
@testable import empowermentLabs
import XCTest

class NetworkServiceTest: XCTestCase {
    private var cancellable: AnyCancellable?
    private var sut: NetworkServiceType!
    private var session: URLSession!
    
    static let baseUrl = "https://api.spoonacular.com"
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        session = URLSession(configuration: config)

        sut = NetworkService(url: DataConstants.baseUrl, urlSession: session)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        cancellable = nil
        URLProtocolMock.testURLs = [:]
        URLProtocolMock.error = nil
        URLProtocolMock.response = nil
    }
    
    func testNetworkService_WhenMakeARequestSuccessful_ThenTheResponseShouldBeSuccess() throws {
        //Given
        let expectationFinished = expectation(description: "finished")
        let expectationReceive = expectation(description: "receiveValue")
        let expectationFailure = expectation(description: "failure")
        expectationFailure.isInverted = true
        let endPoint = NetworkRequest<APIResultResponse>(
            method: .GET,
            relativePath:DataConstants.WS.getRecipesByQuery,
            parameters: nil,
            authorizationToken: DataConstants.apikey)
        let decoder = JSONEncoder()
        let usersURL = URL(string: DataConstants.baseUrl + DataConstants.WS.getRecipesByQuery)!
        let encodedData = try decoder.encode(TestDataConstants.resultResponse)
        let jsonString = String(data: encodedData, encoding: .utf8)
        let jsonData = jsonString!.data(using: .utf8)!
        
        URLProtocolMock.testURLs = [usersURL: jsonData]
        URLProtocolMock.response = HTTPURLResponse(url: URL(string: "http://localhost:5000")!,
                                                   statusCode: 200,
                                                   httpVersion: nil,
                                                   headerFields: nil)
        
        //When
        self.cancellable = sut.request(endPoint, queue: .main)
            .first()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                    expectationFailure.fulfill()
                case .finished:
                    expectationFinished.fulfill()
                }
            }, receiveValue: { response in
                XCTAssertNotNil(response)
                print(response)
                expectationReceive.fulfill()
            })
        
        //Then
        self.wait(for: [expectationFinished, expectationReceive, expectationFailure], timeout: 1)
        self.cancellable?.cancel()
    }
    
    func testNetworkService_WhenMakeARequestSuccessfulButRequestFail_ThenCatchAError() throws {
        //Given
        let expectationFinished = expectation(description: "Invalid.finished")
        expectationFinished.isInverted = true
        let expectationReceive = expectation(description: "Invalid.receiveValue")
        expectationReceive.isInverted = true
        let expectationFailure = expectation(description: "Invalid.failure")
        
        let endPoint = NetworkRequest<APIResultResponse>(
            method: .GET,
            relativePath:DataConstants.WS.getRecipesByQuery,
            parameters: nil,
            authorizationToken: DataConstants.apikey)
        
        URLProtocolMock.response = HTTPURLResponse(url: URL(string: "http://localhost:5000/")!,
                                                   statusCode: 500,
                                                   httpVersion: nil,
                                                   headerFields: nil)
        
        //When
        self.cancellable = sut.request(endPoint, queue: .main)
            .first()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    expectationFailure.fulfill()
                case .finished:
                    expectationFinished.fulfill()
                }
            }, receiveValue: { response in
                XCTAssertNotNil(response)
                print(response)
                expectationReceive.fulfill()
            })
        
        //Then
        self.wait(for: [expectationFinished, expectationReceive, expectationFailure], timeout: 1)
        self.cancellable?.cancel()
    }
    
    func testNetworkService_WhenInvalidURL_ThenCatchAError() throws {
        //Given
        let expectationFinished = expectation(description: "Invalid.finished")
        expectationFinished.isInverted = true
        let expectationReceive = expectation(description: "Invalid.receiveValue")
        expectationReceive.isInverted = true
        let expectationFailure = expectation(description: "Invalid.failure")
        
        sut = NetworkService(url: "", urlSession: session)
        
        let endPoint = NetworkRequest<APIResultResponse>(
            method: .GET,
            relativePath:DataConstants.WS.getRecipesByQuery,
            parameters: nil,
            authorizationToken: DataConstants.apikey)
        
        URLProtocolMock.response = HTTPURLResponse(url: URL(string: "http://localhost:5000/")!,
                                                   statusCode: 500,
                                                   httpVersion: nil,
                                                   headerFields: nil)
        
        //When
        self.cancellable = sut.request(endPoint, queue: .main)
            .first()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    expectationFailure.fulfill()
                case .finished:
                    expectationFinished.fulfill()
                }
            }, receiveValue: { response in
                XCTAssertNotNil(response)
                print(response)
                expectationReceive.fulfill()
            })
        
        //Then
        self.wait(for: [expectationFinished, expectationReceive, expectationFailure], timeout: 1)
        self.cancellable?.cancel()
    }
}
