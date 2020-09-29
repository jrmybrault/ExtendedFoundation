//
//  HTTPCallerTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 18/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class HTTPCallerTests: XCTestCase {
    
    struct Person: Equatable, Codable {
        
        let name: String
        let age: UInt
    }
    
    // MARK: - SUT
    
    private var caller: HTTPCaller!
    
    // MARK: - Mocks
    
    private var mockRequestLauncher: MockRequestLauncher!
    
    // MARK: - Properties
    
    private var fakeRequest: HTTPRequest!
    
    // swiftlint:disable weak_delegate
    private var requestInterceptorDelegate: FakeHTTPRequestInterceptor.Delegate!
    private var resultInterceptorDelegate: FakeHTTPResultInterceptor.Delegate!
    // swiftlint:enable weak_delegate
    
    // MARK: - Funcs
    
    override func setUp() {
        super.setUp()
        
        mockRequestLauncher = MockRequestLauncher()
        
        caller = HTTPCaller(requestLauncher: mockRequestLauncher)
        
        requestInterceptorDelegate = FakeHTTPRequestInterceptor.Delegate()
        resultInterceptorDelegate = FakeHTTPResultInterceptor.Delegate()
        
        let api = HTTPAPI(scheme: .https, host: "testhost.com")
        fakeRequest = HTTPRequest(api: api, identifier: "testIdentifier")
    }
    
    func testActiveStateIsFalseByDefault() {
        // Assert
        XCTAssertFalse(caller.isActive)
    }
    
    func testActiveStateChangeWhenLaunchingRequest() {
        // Arrange
        let expectedObservedIsActiveStates = [true, false]
        
        var observedIsActiveStates = [Bool]()
        
        caller.onIsActiveStateChange = {
            observedIsActiveStates.append($0)
        }
        
        mockRequestLauncher.launchResult = .failure(FakeError())
        
        // Act
        _ = caller.call(request: fakeRequest, onResult: { _ in })
        
        // Assert
        XCTAssertEqual(expectedObservedIsActiveStates, observedIsActiveStates)
    }
    
    func testLaunchingRequestReturnsSuccessWhenLauncherReturnsSuccess() {
        // Arrange
        var receivedResult: HTTPCallResult?
        
        // swiftlint:disable force_unwrapping
        let fakeHTTPURLResponse = HTTPURLResponse(url: URL.fakeURL, statusCode: HTTPStatusCode.ok.value.signed)!
        // swiftlint:enable force_unwrapping
        let fakeCallResponse = HTTPCallResponse(httpResponse: fakeHTTPURLResponse, data: nil)
        let fakeCallResult: HTTPCallResult = .success(fakeCallResponse)
        mockRequestLauncher.launchResult = fakeCallResult
        
        // Act
        _ = caller.call(request: fakeRequest, onResult: {
            receivedResult = $0
        })
        
        // Assert
        guard case let .success(receivedResponse) = receivedResult,
            receivedResponse == fakeCallResponse else {
                XCTFail("Unexpected value for receivedResult.")
                return
        }
    }
    
    func testLaunchingRequestReturnsFailureWhenLauncherReturnsFailure() {
        // Arrange
        var receivedResult: HTTPCallResult?
        
        let fakeError = FakeError()
        let fakeCallResult: HTTPCallResult = .failure(fakeError)
        mockRequestLauncher.launchResult = fakeCallResult
        
        // Act
        _ = caller.call(request: fakeRequest, onResult: {
            receivedResult = $0
        })
        
        // Assert
        guard case let .failure(error) = receivedResult,
            fakeError == error as? FakeError else {
                XCTFail("Unexpected value for receivedResult.")
                return
        }
    }
    
    func testDecodedLaunchingRequestReturnsSuccessWhenLauncherReturnsSuccess() {
        // Arrange
        var receivedResult: HTTPCallDecodedResult<Person>?
        
        // swiftlint:disable force_unwrapping
        let fakeHTTPURLResponse = HTTPURLResponse(url: URL.fakeURL, statusCode: HTTPStatusCode.ok.value.signed)!
        // swiftlint:enable force_unwrapping
        let fakePerson = Person(name: "John Doe", age: 30)
        let fakeData = try? JSONEncoder().encode(fakePerson)
        let fakeCallResponse = HTTPCallResponse(httpResponse: fakeHTTPURLResponse, data: fakeData)
        let fakeCallResult: HTTPCallResult = .success(fakeCallResponse)
        mockRequestLauncher.launchResult = fakeCallResult
        
        // Act
        _ = caller.call(request: fakeRequest, decodingType: Person.self, onResult: {
            receivedResult = $0
        })
        
        // Assert
        guard case let .success(receivedResponse) = receivedResult,
            fakePerson == receivedResponse.value else {
                XCTFail("Unexpected value for receivedResult.")
                return
        }
    }
    
    func testDecodedLaunchingRequestReturnsFailureWhenLauncherReturnsFailure() {
        // Arrange
        var receivedResult: HTTPCallResult?
        
        let fakeError = FakeError()
        let fakeCallResult: HTTPCallResult = .failure(fakeError)
        mockRequestLauncher.launchResult = fakeCallResult
        
        // Act
        _ = caller.call(request: fakeRequest, onResult: {
            receivedResult = $0
        })
        
        // Assert
        guard case let .failure(error) = receivedResult,
            fakeError == error as? FakeError else {
                XCTFail("Unexpected value for receivedResult.")
                return
        }
    }
    
    func testDecodedLaunchingRequestReturnsFailureWhenLauncherReturnsSuccessButThereIsNoDataToDecode() {
        // Arrange
        var receivedResult: HTTPCallDecodedResult<Person>?
        
        // swiftlint:disable force_unwrapping
        let fakeHTTPURLResponse = HTTPURLResponse(url: URL.fakeURL, statusCode: HTTPStatusCode.ok.value.signed)!
        // swiftlint:enable force_unwrapping
        let fakeCallResponse = HTTPCallResponse(httpResponse: fakeHTTPURLResponse, data: nil)
        let fakeCallResult: HTTPCallResult = .success(fakeCallResponse)
        mockRequestLauncher.launchResult = fakeCallResult
        
        // Act
        _ = caller.call(request: fakeRequest, decodingType: Person.self, onResult: {
            receivedResult = $0
        })
        
        // Assert
        guard case let .failure(error) = receivedResult,
            (error as? HTTPUnexpectedEmptyDataError) != nil else {
                XCTFail("Unexpected value for receivedResult.")
                return
        }
    }
    
    func testDecodedLaunchingRequestReturnsFailureWhenLauncherReturnsSuccessButDecodingFails() {
        // Arrange
        var receivedResult: HTTPCallDecodedResult<Person>?
        
        // swiftlint:disable force_unwrapping
        let fakeHTTPURLResponse = HTTPURLResponse(url: URL.fakeURL, statusCode: HTTPStatusCode.ok.value.signed)!
        // swiftlint:enable force_unwrapping
        let fakeData = Data()
        let fakeCallResponse = HTTPCallResponse(httpResponse: fakeHTTPURLResponse, data: fakeData)
        let fakeCallResult: HTTPCallResult = .success(fakeCallResponse)
        mockRequestLauncher.launchResult = fakeCallResult
        
        // Act
        _ = caller.call(request: fakeRequest, decodingType: Person.self, onResult: {
            receivedResult = $0
        })
        
        // Assert
        guard case let .failure(error) = receivedResult,
            let decodingError = error as? HTTPDataDecodingError, decodingError.data == fakeData else {
                XCTFail("Unexpected value for receivedResult.")
                return
        }
    }
    
    func testRequestInterceptorsAreCalledByOrderOfPriorityWhenLaunchingRequest() {
        // Arrange
        let lowPriorityInterceptor = FakeHTTPRequestInterceptor(delegate: requestInterceptorDelegate)
        let mediumPriorityInterceptor = FakeHTTPRequestInterceptor(priority: 1, delegate: requestInterceptorDelegate)
        let highPriorityInterceptor = FakeHTTPRequestInterceptor(priority: 5, delegate: requestInterceptorDelegate)
        
        // Using `shuffled` so the order in which they are added will be randomized
        let allInterceptors = [lowPriorityInterceptor, mediumPriorityInterceptor, highPriorityInterceptor].shuffled()
        allInterceptors.forEach({
            caller.addRequestInterceptor($0)
        })
        
        // Act
        _ = caller.call(request: fakeRequest, decodingType: String.self, onResult: { _ in })
        
        // Assert
        XCTAssertTrue(requestInterceptorDelegate.hasRecorded(allInterceptors.sorted(by: \.priority)))
    }

    func testRequestInterceptorsAreNotCalledWhenLaunchingRequestWithoutPreparing() {
        // Arrange
        let lowPriorityInterceptor = FakeHTTPRequestInterceptor(delegate: requestInterceptorDelegate)
        let mediumPriorityInterceptor = FakeHTTPRequestInterceptor(priority: 1, delegate: requestInterceptorDelegate)
        let highPriorityInterceptor = FakeHTTPRequestInterceptor(priority: 5, delegate: requestInterceptorDelegate)

        // Using `shuffled` so the order in which they are added will be randomized
        let allInterceptors = [lowPriorityInterceptor, mediumPriorityInterceptor, highPriorityInterceptor].shuffled()
        allInterceptors.forEach({
            caller.addRequestInterceptor($0)
        })

        // Act
        _ = caller.call(request: fakeRequest, shouldPrepareRequest: false, decodingType: String.self, onResult: { _ in })

        // Assert
        XCTAssertTrue(requestInterceptorDelegate.recordedInterceptors.isEmpty)
    }
    
    func testOnlyRequestInterceptorsThatWereNotRemovedAreCalledWhenLaunchingRequest() {
        // Arrange
        let lowPriorityInterceptor = FakeHTTPRequestInterceptor(delegate: requestInterceptorDelegate)
        let mediumPriorityInterceptor = FakeHTTPRequestInterceptor(priority: 1, delegate: requestInterceptorDelegate)
        let highPriorityInterceptor = FakeHTTPRequestInterceptor(priority: 5, delegate: requestInterceptorDelegate)
        
        // Using `shuffled` so the order in which they are added will be randomized
        let allInterceptors = [lowPriorityInterceptor, mediumPriorityInterceptor, highPriorityInterceptor].shuffled()
        allInterceptors.forEach({
            caller.addRequestInterceptor($0)
        })
        
        caller.removeRequestInterceptor(highPriorityInterceptor)
        
        // Act
        _ = caller.call(request: fakeRequest, decodingType: String.self, onResult: { _ in })
        
        // Assert
        XCTAssertTrue(requestInterceptorDelegate.hasRecorded([lowPriorityInterceptor, mediumPriorityInterceptor].sorted(by: \.priority)))
    }
    
    func testResultInterceptorsAreCalledByOrderOfPriorityWhenLaunchingRequest() {
        // Arrange
        let lowPriorityInterceptor = FakeHTTPResultInterceptor(delegate: resultInterceptorDelegate)
        let mediumPriorityInterceptor = FakeHTTPResultInterceptor(priority: 1, delegate: resultInterceptorDelegate)
        let highPriorityInterceptor = FakeHTTPResultInterceptor(priority: 5, delegate: resultInterceptorDelegate)
        
        // Using `shuffled` so the order in which they are added will be randomized
        let allInterceptors = [lowPriorityInterceptor, mediumPriorityInterceptor, highPriorityInterceptor].shuffled()
        allInterceptors.forEach({
            caller.addResultInterceptor($0)
        })
        
        mockRequestLauncher.launchResult = .failure(FakeError())
        
        // Act
        _ = caller.call(request: fakeRequest, decodingType: String.self, onResult: { _ in })
        
        // Assert
        XCTAssertTrue(resultInterceptorDelegate.hasRecorded(allInterceptors.sorted(by: \.priority)))
    }

    func testResultInterceptorsAreNotCalledWhenLaunchingRequestWithoutConveying() {
        // Arrange
        let lowPriorityInterceptor = FakeHTTPResultInterceptor(delegate: resultInterceptorDelegate)
        let mediumPriorityInterceptor = FakeHTTPResultInterceptor(priority: 1, delegate: resultInterceptorDelegate)
        let highPriorityInterceptor = FakeHTTPResultInterceptor(priority: 5, delegate: resultInterceptorDelegate)

        // Using `shuffled` so the order in which they are added will be randomized
        let allInterceptors = [lowPriorityInterceptor, mediumPriorityInterceptor, highPriorityInterceptor].shuffled()
        allInterceptors.forEach({
            caller.addResultInterceptor($0)
        })

        mockRequestLauncher.launchResult = .failure(FakeError())

        // Act
        _ = caller.call(request: fakeRequest, decodingType: String.self, shouldConveyResult: false, onResult: { _ in })

        // Assert
        XCTAssertTrue(resultInterceptorDelegate.recordedInterceptors.isEmpty)
    }
    
    func testOnlyResultInterceptorsThatWereNotRemovedAreCalledWhenLaunchingRequest() {
        // Arrange
        let lowPriorityInterceptor = FakeHTTPResultInterceptor(delegate: resultInterceptorDelegate)
        let mediumPriorityInterceptor = FakeHTTPResultInterceptor(priority: 1, delegate: resultInterceptorDelegate)
        let highPriorityInterceptor = FakeHTTPResultInterceptor(priority: 5, delegate: resultInterceptorDelegate)
        
        // Using `shuffled` so the order in which they are added will be randomized
        let allInterceptors = [lowPriorityInterceptor, mediumPriorityInterceptor, highPriorityInterceptor].shuffled()
        allInterceptors.forEach({
            caller.addResultInterceptor($0)
        })
        
        caller.removeResultInterceptor(highPriorityInterceptor)
        
        mockRequestLauncher.launchResult = .failure(FakeError())
        
        // Act
        _ = caller.call(request: fakeRequest, decodingType: String.self, onResult: { _ in })
        
        // Assert
        XCTAssertTrue(resultInterceptorDelegate.hasRecorded([lowPriorityInterceptor, mediumPriorityInterceptor].sorted(by: \.priority)))
    }
    
    func testOnlyResultInterceptorsThatShouldActuallyInterceptAreCalledWhenLaunchingRequest() {
        // Arrange
        let lowPriorityInterceptor = FakeHTTPResultInterceptor(delegate: resultInterceptorDelegate)
        let mediumPriorityInterceptor = FakeHTTPResultInterceptor(priority: 1, delegate: resultInterceptorDelegate)
        mediumPriorityInterceptor.shouldIntercept = false
        let highPriorityInterceptor = FakeHTTPResultInterceptor(priority: 5, delegate: resultInterceptorDelegate)
        
        // Using `shuffled` so the order in which they are added will be randomized
        let allInterceptors = [lowPriorityInterceptor, mediumPriorityInterceptor, highPriorityInterceptor].shuffled()
        allInterceptors.forEach({
            caller.addResultInterceptor($0)
        })
        
        mockRequestLauncher.launchResult = .failure(FakeError())
        
        // Act
        _ = caller.call(request: fakeRequest, decodingType: String.self, onResult: { _ in })
        
        // Assert
        XCTAssertTrue(resultInterceptorDelegate.hasRecorded([lowPriorityInterceptor, highPriorityInterceptor].sorted(by: \.priority)))
    }
}

fileprivate final class MockRequestLauncher: HTTPRequestLauncher {
    
    // MARK: - Properties
    
    var launchRequest: HTTPRequest?
    var launchQueue: DispatchQueue?
    var launchResult: HTTPCallResult?

    // MARK: - Funcs
    
    func launch(_ request: HTTPRequest, onResult: @escaping Consumer<HTTPCallResult>) -> CancellableTask {
        launchRequest = request
        
        let launchTask = CleanTask()
        
        if let launchQueue = launchQueue {
            launchQueue.async {
                if let launchResult = self.launchResult, !launchTask.isCancelled {
                    onResult(launchResult)
                }
            }
        } else {
            if let launchResult = self.launchResult {
                onResult(launchResult)
            }
        }
        
        return launchTask
    }
}

fileprivate final class FakeHTTPRequestInterceptor: HTTPRequestInterceptor {
    
    class Delegate {
        
        // MARK: - Properties
        
        private(set) var recordedInterceptors: [HTTPRequestInterceptor] = []
        
        // MARK: - Funcs
        
        func interceptorDidIntercept(_ interceptor: HTTPRequestInterceptor) {
            recordedInterceptors.append(interceptor)
        }
        
        func hasRecorded(_ interceptors: [HTTPRequestInterceptor]) -> Bool {
            guard recordedInterceptors.count == interceptors.count else { return false }
            
            return interceptors.enumerated().allSatisfy { offset, interceptor in
                return recordedInterceptors[offset] === interceptor
            }
        }
    }
    
    // MARK: - Properties
    
    let priority: UInt
    
    private weak var delegate: Delegate?
    
    // MARK: - Init
    
    init(priority: UInt = UInt.min, delegate: Delegate? = nil) {
        self.priority = priority
        self.delegate = delegate
    }
    
    // MARK: - Funcs
    
    func intercept(_ request: HTTPRequest) -> HTTPRequest {
        delegate?.interceptorDidIntercept(self)
        
        return request
    }
}

fileprivate final class FakeHTTPResultInterceptor: HTTPResultInterceptor {
    
    class Delegate {
        
        // MARK: - Properties
        
        private(set) var recordedInterceptors: [HTTPResultInterceptor] = []
        
        // MARK: - Funcs
        
        func interceptorDidIntercept(_ interceptor: HTTPResultInterceptor) {
            recordedInterceptors.append(interceptor)
        }
        
        func hasRecorded(_ interceptors: [HTTPResultInterceptor]) -> Bool {
            guard recordedInterceptors.count == interceptors.count else { return false }
            
            return interceptors.enumerated().allSatisfy { offset, interceptor in
                return recordedInterceptors[offset] === interceptor
            }
        }
    }
    
    // MARK: - Properties
    
    let priority: UInt
    
    var shouldIntercept: Bool = true
    
    private weak var delegate: Delegate?
    
    // MARK: - Init
    
    init(priority: UInt = UInt.min, delegate: Delegate? = nil) {
        self.priority = priority
        self.delegate = delegate
    }
    
    // MARK: - Funcs
    
    func shouldIntercept(_ request: HTTPRequest) -> Bool {
        return shouldIntercept
    }
    
    func intercept(_ result: HTTPCallResult, for request: HTTPRequest) {
        delegate?.interceptorDidIntercept(self)
    }
}
