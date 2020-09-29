//
//  ProcessInfoUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class ProcessInfoUtilsTests: XCTestCase {

    // MARK: - Funcs

    func testIsActuallyUnitTesting() {
        // Assert
        XCTAssertTrue(ProcessInfo.isUnitTesting)
    }
}
