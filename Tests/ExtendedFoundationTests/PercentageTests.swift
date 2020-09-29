//
//  PercentageTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class PercentageTests: XCTestCase {

    // MARK: - Funcs

    func testFloatingValue() {
        // Arrange
        let percentage = Percentage(83)

        // Assert
        XCTAssertEqual(0.83, percentage.double)
    }
}
