//
//  ResultUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class ResultUtilsTests: XCTestCase {

    // MARK: - Funcs

    func testIsSuccess() {
        // Arrange
        let successResult: Result<String, FakeError> = .success("test")
        let failureResult: Result<String, FakeError> = .failure(FakeError())

        // Assert
        XCTAssertTrue(successResult.isSuccess)
        XCTAssertFalse(failureResult.isSuccess)
    }

    func testIsFailure() {
        // Arrange
        let successResult: Result<String, FakeError> = .success("test")
        let failureResult: Result<String, FakeError> = .failure(FakeError())

        // Assert
        XCTAssertFalse(successResult.isFailure)
        XCTAssertTrue(failureResult.isFailure)
    }
}
