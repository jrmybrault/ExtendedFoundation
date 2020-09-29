//
//  DurationTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class DurationTests: XCTestCase {

    // MARK: - Funcs

    func testConvertions() {
        // Arrange
        let twoWeeksDuration = Duration(2, .week)

        // Assert
        XCTAssertEqual(2 * 7, twoWeeksDuration.in(.day))
        XCTAssertEqual(2 * 7 * 24, twoWeeksDuration.in(.hour))
        XCTAssertEqual(2 * 7 * 24 * 60, twoWeeksDuration.in(.minute))
        XCTAssertEqual(2 * 7 * 24 * 60 * 60, twoWeeksDuration.in(.second))
        XCTAssertEqual(2 * 7 * 24 * 60 * 60 * 10, twoWeeksDuration.in(.centisecond))
        XCTAssertEqual(2 * 7 * 24 * 60 * 60 * 10 * 10, twoWeeksDuration.in(.decisecond))
        XCTAssertEqual(2 * 7 * 24 * 60 * 60 * 10 * 10 * 10, twoWeeksDuration.in(.millisecond))
    }
}
