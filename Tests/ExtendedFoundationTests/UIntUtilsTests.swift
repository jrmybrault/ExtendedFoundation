//
//  UIntUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class UIntUtilsTests: XCTestCase {

    // MARK: - Funcs

    func testIsWithinReturnsTrueOnlyWhenValueIsWithinRange() {
        // Arrange
        let value: UInt = 10

        // Assert
        XCTAssertTrue(value.isWithin(9 ..< 11))
        XCTAssertFalse(value.isWithin(UInt.min ..< 10))
        XCTAssertFalse(value.isWithin(11 ..< UInt.max))
    }
}
