//
//  ValidableTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 20/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class ValidableTests: XCTestCase {

   // MARK: - Funcs

    func testIsValidByDefault() {
        // Arrange
        let validable = BaseValidable()

        // Assert
        XCTAssertTrue(validable.isValid)
    }
}

fileprivate final class BaseValidable: Validable {

    func validationError() -> Error? {
        return nil
    }

    func observeValidationChange(_ observer: @escaping Consumer<Error?>) -> ObservingToken {
        return ObservingToken()
    }
}
