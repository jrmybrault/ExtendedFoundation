//
//  HTTPAPITests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 18/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class HTTPAPITests: XCTestCase {

    // MARK: - Funcs

    func testURComponents() {
        // Arrange
        let api = HTTPAPI(scheme: .https, host: "test.host.com", port: 67, path: "/test/api")

        // Act
        let urlComponents = api.urlComponents

        // Assert
        XCTAssertEqual(api.scheme.rawValue, urlComponents.scheme)
        XCTAssertEqual(api.host, urlComponents.host)
        XCTAssertEqual(api.port, urlComponents.port)
        XCTAssertEqual((api.path ?? "") + "/", urlComponents.path)
        XCTAssertNil(urlComponents.fragment)
        XCTAssertNil(urlComponents.password)
        XCTAssertNil(urlComponents.query)
        XCTAssertNil(urlComponents.queryItems)
        XCTAssertNil(urlComponents.user)
    }

    func testURL() {
        // Arrange
        let api = HTTPAPI(scheme: .http, host: "test.host.fr", port: 44, path: "/test/api/v2")

        // Act
        let url = api.url

        // Assert
        XCTAssertEqual(api.scheme.rawValue, url.scheme)
        XCTAssertEqual(api.host, url.host)
        XCTAssertEqual(api.port, url.port)
        XCTAssertEqual(api.path, url.path)
        XCTAssertNil(url.fragment)
        XCTAssertNil(url.password)
        XCTAssertNil(url.query)
        XCTAssertNil(url.user)
    }
}
