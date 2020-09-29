//
//  StatusCodeResultInterceptorTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class StatusCodeInterceptorTests: XCTestCase {

    // MARK: - Funcs

    func testInterceptCallCallbackWhenStatusCodeMatches() {
        // Arrange
        let statusCodeToIntercept: HTTPStatusCode = .unauthorized

        let api = HTTPAPI(scheme: .https, host: "testhost.com")
        let request = HTTPRequest(api: api, identifier: "testIdentifier")
        // swiftlint:disable force_unwrapping
        let httpURLResponse = HTTPURLResponse(url: URL.fakeURL, statusCode: statusCodeToIntercept.value.signed)!
        // swiftlint:enable force_unwrapping
        let result: HTTPCallResult = .failure(HTTPError.other(httpURLResponse, nil, nil))

        let callExpectation = XCTestExpectation()

        let interceptor = StatusCodeResultInterceptor(statusCode: statusCodeToIntercept, callback: {
            callExpectation.fulfill()
        })

        // Act
        interceptor.intercept(result, for: request)

        // Assert
        wait(for: [callExpectation], timeout: TestConstants.defaultExpectationTimeout)
    }

    func testInterceptDoNotCallCallbackWhenStatusCodeDoesNotMatch() {
        // Arrange
        let statusCodeToIntercept: HTTPStatusCode = .badRequest

        let api = HTTPAPI(scheme: .https, host: "testhost.com")
        let request = HTTPRequest(api: api, identifier: "testIdentifier")
        // swiftlint:disable force_unwrapping
        let httpURLResponse = HTTPURLResponse(url: URL.fakeURL, statusCode: HTTPStatusCode.noContent.value.signed)!
        // swiftlint:enable force_unwrapping
        let result: HTTPCallResult = .failure(HTTPError.other(httpURLResponse, nil, nil))

        let callExpectation = XCTestExpectation()
        callExpectation.isInverted = true

        let interceptor = StatusCodeResultInterceptor(statusCode: statusCodeToIntercept, callback: {
            callExpectation.fulfill()
        })

        // Act
        interceptor.intercept(result, for: request)

        // Assert
        wait(for: [callExpectation], timeout: TestConstants.defaultExpectationTimeout)
    }
}
