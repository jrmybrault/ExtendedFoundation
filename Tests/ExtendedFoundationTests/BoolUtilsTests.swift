//
//  BoolUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class BoolUtilsTests: XCTestCase {

    // MARK: - Funcs

    func testIsTruePredicate() {
        // Arrange
        let isTruePredicate = Bool.isTrue(or: { FakeError() })

        // Assert
        XCTAssertNil(isTruePredicate(true))
        XCTAssertEqual(FakeError(), isTruePredicate(false) as? FakeError)
    }

    func testIsFalsePredicate() {
        // Arrange
        let isFalsePredicate = Bool.isFalse(or: { FakeError() })

        // Assert
        XCTAssertNil(isFalsePredicate(false))
        XCTAssertEqual(FakeError(), isFalsePredicate(true) as? FakeError)
    }
}
