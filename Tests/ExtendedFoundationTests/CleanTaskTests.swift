//
//  CleanTaskTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class CleanTaskTests: XCTestCase {

    // MARK: - SUT

    private var task: CleanTask!

    // MARK: - Funcs

    override func setUp() {
        super.setUp()

        task = CleanTask()
    }

    func testMarkAsCancelledWhenCancelling() {
        // Act
        task.cancel()

        // Assert
        XCTAssertTrue(task.isCancelled)
    }
}
