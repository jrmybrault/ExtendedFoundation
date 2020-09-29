//
//  URLErrorUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class URLErrorUtilsTests: XCTestCase {

    // MARK: - Funcs

    func testIsCancellationOnlyWhenCodeMatches() {
        // Assert
        XCTAssertFalse(URLError(URLError.backgroundSessionInUseByAnotherProcess).isCancellation)
        XCTAssertFalse(URLError(URLError.notConnectedToInternet).isCancellation)
        XCTAssertFalse(URLError(URLError.badServerResponse).isCancellation)
        XCTAssertTrue(URLError(URLError.cancelled).isCancellation)
        XCTAssertFalse(URLError(URLError.cannotDecodeRawData).isCancellation)
    }
}
