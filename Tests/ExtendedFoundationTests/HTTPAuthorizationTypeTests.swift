//
//  HTTPAuthorizationTypeTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class HTTPAuthorizationTypeTests: XCTestCase {

    // MARK: - Funcs

    func testBearerValue() {
        // Arrange
        let bearerValue = "test bearer"
        let authorizationType: HTTPAuthorizationType = .bearer(bearerValue)

        // Assert
        XCTAssertEqual("Bearer \(bearerValue)", authorizationType.value)
    }
}
