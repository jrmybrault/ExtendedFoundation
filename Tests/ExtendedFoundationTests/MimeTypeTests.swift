//
//  MimeTypeTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class MimeTypeTests: XCTestCase {

    // MARK: - Funcs

    func testValueFormatWhenUsingParameter() {
        // Arrange
        let category: MimeType.Category = .multipartFormData
        let parameterName = "boundary"
        let parameterValue = "test paramater"
        let mimeType = MimeType(category, parameter: (parameterName, parameterValue))

        // Assert
        XCTAssertEqual("\(category.description); \(parameterName)=\(parameterValue)", mimeType.description)
    }

    func testValueFormatWhenNotUsingParameter() {
        // Arrange
        let category: MimeType.Category = .textHtml
        let mimeType = MimeType(category)

        // Assert
        XCTAssertEqual(category.description, mimeType.description)
    }
}
