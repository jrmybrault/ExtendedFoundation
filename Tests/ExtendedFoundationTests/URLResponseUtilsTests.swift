//
//  URLResponseUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class URLResponseUtilsTests: XCTestCase {

    // MARK: - Funcs

    func testMimeTypeReturnsProperMimeTypeWhenValueIsValid() {
        // Assert
        XCTAssertEqual(MimeType(.textHtml), URLResponse(url: URL.fakeURL,
                                                        mimeType: "text/html",
                                                        expectedContentLength: 0,
                                                        textEncodingName: nil)
            .mimeType())
        XCTAssertEqual(MimeType(.json), URLResponse(url: URL.fakeURL,
                                                    mimeType: "application/json",
                                                    expectedContentLength: 0,
                                                    textEncodingName: nil)
            .mimeType())
        XCTAssertEqual(MimeType(.pngImage), URLResponse(url: URL.fakeURL,
                                                        mimeType: "image/png",
                                                        expectedContentLength: 0,
                                                        textEncodingName: nil)
            .mimeType())
        XCTAssertEqual(MimeType(.multipartFormData), URLResponse(url: URL.fakeURL,
                                                                 mimeType: "multipart/form-data",
                                                                 expectedContentLength: 0,
                                                                 textEncodingName: nil)
            .mimeType())
        XCTAssertEqual(MimeType(.multipartFormData, parameter: ("name", "testvalue")), URLResponse(url: URL.fakeURL,
                                                                                                   mimeType: "multipart/form-data; name=testvalue",
                                                                                                   expectedContentLength: 0,
                                                                                                   textEncodingName: nil)
            .mimeType())
    }
}
