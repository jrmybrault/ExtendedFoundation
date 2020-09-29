//
//  StringUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class StringUtilsTests: XCTestCase {

    // MARK: - Funcs

    func testInitFromRepeteadCharacterWithUnsignedCount() {
        // Arrange
        let characterToRepeat: Character = "X"
        let count: UInt = 3

        // Assert
        XCTAssertEqual(String(repeating: characterToRepeat, count: count.signed),
                       String(repeating: characterToRepeat, count: count))
    }

    func testIsNotEmpty() {
        // Assert
        XCTAssertTrue("t".isNotEmpty)
        XCTAssertTrue("test".isNotEmpty)
        XCTAssertTrue("test string".isNotEmpty)
        XCTAssertFalse("".isNotEmpty)
    }

    func testTrimWhitespacesAndNewlines() {
        // Assert
        XCTAssertEqual("t", "t".trimWhitespacesAndNewlines())
        XCTAssertEqual("test", "test".trimWhitespacesAndNewlines())
        XCTAssertEqual("test string", " test string".trimWhitespacesAndNewlines())
        XCTAssertEqual("test string", "test string ".trimWhitespacesAndNewlines())
        XCTAssertEqual("test string", " test string ".trimWhitespacesAndNewlines())
        XCTAssertEqual("test string", "  test string  ".trimWhitespacesAndNewlines())
        XCTAssertEqual("test string", "\ntest string".trimWhitespacesAndNewlines())
        XCTAssertEqual("test\nstring", "test\nstring\n".trimWhitespacesAndNewlines())
        XCTAssertEqual("test\nstring", "\ntest\nstring\n".trimWhitespacesAndNewlines())
        XCTAssertEqual("test\nstring", "\n\ntest\nstring\n\n".trimWhitespacesAndNewlines())
        XCTAssertEqual("test string \n test string 2", " \n test string \n test string 2\n \n".trimWhitespacesAndNewlines())
    }

    func testIsLongerOrEqualPredicate() {
        // Arrange
        let isLongerThanPredicate = String.isLongerOrEqual(to: 5, or: { FakeError() })

        // Assert
        XCTAssertEqual(FakeError(), isLongerThanPredicate("") as? FakeError)
        XCTAssertEqual(FakeError(), isLongerThanPredicate("t") as? FakeError)
        XCTAssertEqual(FakeError(), isLongerThanPredicate("test") as? FakeError)
        XCTAssertNil(isLongerThanPredicate("test1") as? FakeError)
        XCTAssertNil(isLongerThanPredicate("test1 test2") as? FakeError)
    }

    func testIsSmallerOrEqualPredicte() {
        // Arrange
        let isSmallerThanPredicate = String.isSmallerOrEqual(to: 7, or: { FakeError() })

        // Assert
        XCTAssertEqual(FakeError(), isSmallerThanPredicate("test1 test2") as? FakeError)
        XCTAssertEqual(FakeError(), isSmallerThanPredicate("test1 te") as? FakeError)
        XCTAssertNil(isSmallerThanPredicate("test1 t"))
        XCTAssertNil(isSmallerThanPredicate("test1 "))
        XCTAssertNil(isSmallerThanPredicate("t"))
    }

    func testMachesPredicate() {
        // Arrange
        let matchesPredicate = String.matches(NSRegularExpression.email, or: { FakeError() })

        // Assert
        XCTAssertEqual(FakeError(), matchesPredicate("john.doe") as? FakeError)
        XCTAssertEqual(FakeError(), matchesPredicate("john.doe@") as? FakeError)
        XCTAssertEqual(FakeError(), matchesPredicate("john.doe@open-groupe") as? FakeError)
        XCTAssertEqual(FakeError(), matchesPredicate("john.doe@open-groupe.") as? FakeError)
        XCTAssertNil(matchesPredicate("john.doe@open-groupe.com"))
    }

    func testIsWithinPredicate() {
        // Arrange
        let isWithinPredicate = String.isWithin(["test1", "test3", "testA"], or: { FakeError() })

        // Assert
        XCTAssertEqual(FakeError(), isWithinPredicate("test2") as? FakeError)
        XCTAssertEqual(FakeError(), isWithinPredicate("test1 test2") as? FakeError)
        XCTAssertEqual(FakeError(), isWithinPredicate("test2 test1 test2 testA test2 test3") as? FakeError)
        XCTAssertEqual(FakeError(), isWithinPredicate(" test1") as? FakeError)
        XCTAssertEqual(FakeError(), isWithinPredicate("test") as? FakeError)
        XCTAssertEqual(FakeError(), isWithinPredicate("test3 ") as? FakeError)
        XCTAssertNil(isWithinPredicate("test1"))
        XCTAssertNil(isWithinPredicate("test3"))
        XCTAssertNil(isWithinPredicate("testA"))
    }

    func testIsEmptyOrNil() {
        // Assert
        XCTAssertTrue(Optional(nil).isEmptyOrNil)
        XCTAssertTrue(Optional("").isEmptyOrNil)
        XCTAssertFalse(Optional(" ").isEmptyOrNil)
        XCTAssertFalse(Optional("t").isEmptyOrNil)
        XCTAssertFalse(Optional("test").isEmptyOrNil)
    }

    func testIsNorEmptyNorNil() {
        // Assert
        XCTAssertFalse(Optional(nil).isNorEmptyNorNil)
        XCTAssertFalse(Optional("").isNorEmptyNorNil)
        XCTAssertTrue(Optional(" ").isNorEmptyNorNil)
        XCTAssertTrue(Optional("t").isNorEmptyNorNil)
        XCTAssertTrue(Optional("test").isNorEmptyNorNil)
    }
}
