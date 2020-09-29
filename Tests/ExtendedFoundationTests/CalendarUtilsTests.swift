//
//  CalendarUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class CalendarUtilsTests: XCTestCase {

    // MARK: - Funcs

    func testInitDateSucceedsWhenUsingValidValues() {
        // Arrange
        let year: UInt = 2020
        let month: UInt = 4
        let day: UInt = 16

        // Act
        let date = Calendar.date(year: year, month: month, day: day)

        // Assert
        XCTAssertNotNil(date)

        // swiftlint:disable force_unwrapping
        let createdDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date!)
        // swiftlint:enable force_unwrapping

        XCTAssertEqual(year, createdDateComponents.year?.unsigned)
        XCTAssertEqual(month, createdDateComponents.month?.unsigned)
        XCTAssertEqual(day, createdDateComponents.day?.unsigned)
    }
}
