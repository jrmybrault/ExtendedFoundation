//
//  HTTPResultInterceptorTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 20/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class HTTPResultInterceptorTests: XCTestCase {

    // MARK: - Funcs

    func testShouldInterceptResultByDefault() {
        // Arrange
        let interceptor = BaseResultInterceptor()

        let api = HTTPAPI(scheme: .https, host: "testhost.com")
        let request = HTTPRequest(api: api, identifier: "testIdentifier")

        // Assert
        XCTAssertTrue(interceptor.shouldIntercept(request))
    }

    func testPriorityIsMinimalByDefault() {
        // Arrange
        let interceptor = BaseResultInterceptor()

        // Assert
        XCTAssertEqual(UInt.min, interceptor.priority)
    }
}

fileprivate final class BaseResultInterceptor: HTTPResultInterceptor {

    func intercept(_ result: HTTPCallResult, for request: HTTPRequest) {
    }
}
