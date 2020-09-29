//
//  AuthorizationRequestInterceptorTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class AuthorizationRequestInterceptorTests: XCTestCase {

    // MARK: - Funcs

    func testAddAuthorizationHeaderWhenIntercepting() {
        // Arrange
        let fakeAuthorization = "test authorization single header"

        let interceptor = AuthorizationRequestInterceptor()
        interceptor.authorization = fakeAuthorization

        let api = HTTPAPI(scheme: .https, host: "testhost.com")
        let request = HTTPRequest(api: api, identifier: "testIdentifier")

        // Act
        let requestAfterInterception = interceptor.intercept(request)

        // Assert
        XCTAssertEqual([.authorization(.bearer(fakeAuthorization))], requestAfterInterception.headers)
    }

    func testAddAuthorizationHeaderToOtherHeadersWhenIntercepting() {
        // Arrange
        let fakeAuthorization = "test authorization multiple headers"

        let interceptor = AuthorizationRequestInterceptor()
        interceptor.authorization = fakeAuthorization

        let api = HTTPAPI(scheme: .https, host: "testhost.com")
        let headers: [HTTPHeader] = [.accept(MimeType(.json)), .acceptEncoding("utf-8")]
        let request = HTTPRequest(api: api, identifier: "testIdentifier", headers: headers)

        // Act
        let requestAfterInterception = interceptor.intercept(request)

        // Assert
        XCTAssertEqual(headers + [.authorization(.bearer(fakeAuthorization))], requestAfterInterception.headers)
    }

    func testDoNotAddEmptyAuthorizationHeaderWhenIntercepting() {
        // Arrange
        let fakeAuthorization: String? = nil

        let interceptor = AuthorizationRequestInterceptor()
        interceptor.authorization = fakeAuthorization

        let api = HTTPAPI(scheme: .https, host: "testhost.com")
        let request = HTTPRequest(api: api, identifier: "testIdentifier")

        // Act
        let requestAfterInterception = interceptor.intercept(request)

        // Assert
        XCTAssertTrue(requestAfterInterception.headers.isEmpty)
    }
}
