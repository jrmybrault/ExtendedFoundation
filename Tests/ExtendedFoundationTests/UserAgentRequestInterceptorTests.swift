//
//  UserAgentRequestInterceptorTests.swift
//  ExtendedFoundation
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class UserAgentRequestInterceptorTests: XCTestCase {

    // MARK: - Funcs

    func testAddUserAgentHeaderWhenIntercepting() {
        // Arrange
       let userAgent = "test user agent single header"

        let interceptor = UserAgentRequestInterceptor(userAgent: userAgent)

        let api = HTTPAPI(scheme: .https, host: "testhost.com")
               let request = HTTPRequest(api: api, identifier: "testIdentifier")

        // Act
        let requestAfterInterception = interceptor.intercept(request)

        // Assert
        XCTAssertEqual([.userAgent(userAgent)], requestAfterInterception.headers)
    }

    func testAddAuthorizationHeaderToOtherHeadersWhenIntercepting() {
        // Arrange
        let userAgent = "test user agent multiple headers"

        let interceptor = UserAgentRequestInterceptor(userAgent: userAgent)

        let api = HTTPAPI(scheme: .https, host: "testhost.com")
        let headers: [HTTPHeader] = [.accept(MimeType(.json)), .acceptEncoding("utf-8")]
        let request = HTTPRequest(api: api, identifier: "testIdentifier", headers: headers)

        // Act
        let requestAfterInterception = interceptor.intercept(request)

        // Assert
        XCTAssertEqual(headers + [.userAgent(userAgent)], requestAfterInterception.headers)
    }
}
