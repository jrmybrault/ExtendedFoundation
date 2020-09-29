//
//  HTTPStatusCodeTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class HTTPStatusCodeTests: XCTestCase {

    // MARK: - Funcs

    func testContinueIsAnInformationStatus() {
        // Assert
        XCTAssertTrue(HTTPStatusCode.continue.isInformation)
        XCTAssertFalse(HTTPStatusCode.continue.isSuccess)
        XCTAssertFalse(HTTPStatusCode.continue.isRedirection)
        XCTAssertFalse(HTTPStatusCode.continue.isClientError)
        XCTAssertFalse(HTTPStatusCode.continue.isServerError)
    }

    func testOkIsASuccessStatus() {
        // Assert
        XCTAssertFalse(HTTPStatusCode.ok.isInformation)
        XCTAssertTrue(HTTPStatusCode.ok.isSuccess)
        XCTAssertFalse(HTTPStatusCode.ok.isRedirection)
        XCTAssertFalse(HTTPStatusCode.ok.isClientError)
        XCTAssertFalse(HTTPStatusCode.ok.isServerError)
    }

    func testMultipleChoicesIsARedirectionStatus() {
        // Assert
        XCTAssertFalse(HTTPStatusCode.multipleChoices.isInformation)
        XCTAssertFalse(HTTPStatusCode.multipleChoices.isSuccess)
        XCTAssertTrue(HTTPStatusCode.multipleChoices.isRedirection)
        XCTAssertFalse(HTTPStatusCode.multipleChoices.isClientError)
        XCTAssertFalse(HTTPStatusCode.multipleChoices.isServerError)
    }

    func testBadRequestIsAClientErrorStatus() {
        // Assert
        XCTAssertFalse(HTTPStatusCode.badRequest.isInformation)
        XCTAssertFalse(HTTPStatusCode.badRequest.isSuccess)
        XCTAssertFalse(HTTPStatusCode.badRequest.isRedirection)
        XCTAssertTrue(HTTPStatusCode.badRequest.isClientError)
        XCTAssertFalse(HTTPStatusCode.badRequest.isServerError)
    }

    func testInternalServerErrorIsAServerErrorStatus() {
        // Assert
        XCTAssertFalse(HTTPStatusCode.internalServerError.isInformation)
        XCTAssertFalse(HTTPStatusCode.internalServerError.isSuccess)
        XCTAssertFalse(HTTPStatusCode.internalServerError.isRedirection)
        XCTAssertFalse(HTTPStatusCode.internalServerError.isClientError)
        XCTAssertTrue(HTTPStatusCode.internalServerError.isServerError)
    }
}
