//
//  HTTPRequestLoggingInterceptorTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 20/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class HTTPRequestLoggingInterceptorTests: XCTestCase {

    // MARK: - Funcs

    func testInterceptDoesNotModifyRequest() {
        // Arrange
        let interceptor = HTTPRequestLoggingInterceptor()

        let api = HTTPAPI(scheme: .https, host: "testhost.com")
        let request = HTTPRequest(api: api, identifier: "testIdentifier")

        // Act
        let requestAfterInterception = interceptor.intercept(request)

        // Assert
        XCTAssertEqual(requestAfterInterception, request)
    }
}
