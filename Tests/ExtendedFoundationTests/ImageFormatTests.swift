//
//  ImageFormatTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class ImageFormatTests: XCTestCase {

    // MARK: - Funcs

    func testJPEGExtension() {
        // Arrange
        let format = ImageFormat.jpeg(compressionQuality: Percentage(10))

        // Assert
        XCTAssertEqual("jpeg", format.extension)
    }

    func testJPEGMimeType() {
        // Arrange
        let format = ImageFormat.jpeg(compressionQuality: Percentage(10))

        // Assert
        XCTAssertEqual(MimeType(.jpegImage), format.mimeType)
    }

    func testPNGExtension() {
        // Arrange
        let format = ImageFormat.png

        // Assert
        XCTAssertEqual("png", format.extension)
    }

    func testPNGMimeType() {
        // Arrange
        let format = ImageFormat.png

        // Assert
        XCTAssertEqual(MimeType(.pngImage), format.mimeType)
    }
}
