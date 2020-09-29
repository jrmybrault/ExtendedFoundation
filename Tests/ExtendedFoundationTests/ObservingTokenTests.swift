//
//  ObservingTokenTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class ObservingTokenTests: XCTestCase {

    // MARK: - Funcs

    func testTokensAreUnique() {
        // Arrange
        let tokens = Array(producing: ObservingToken.init, count: 10_000)
        let uniqueTokens = Set(tokens) // Use Set to remove any duplicates

        // Assert
        XCTAssertEqual(tokens.count, uniqueTokens.count)
    }
}
