//
//  ArrayUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class ArrayUtilsTests: XCTestCase {

    // MARK: - Funcs

    func testUnsignedSubscriptIsEqualToSignedSubscript() {
        // Arrange
        let array = (0 ..< 100).map({ "Value \($0)" })

        // Assert
        (0 ..< array.count).forEach({
            if array[$0] != array[$0.unsigned] {
                XCTFail("Unexpected value: \(array[$0.unsigned]) while expecting \(array[$0]).")
            }
        })
    }

    func testUnsignedFirstIndexReturnsProperIndexWhenValueIsPresent() {
        // Arrange
        let array = (0 ..< 100).map({ "Value \($0)" })

        let searchedValue = 51

        // Act
        let foundIndex = array.unsignedFirstIndex(of: "Value \(searchedValue)")

        // Assert
        XCTAssertEqual(searchedValue, foundIndex?.signed)
    }

    func testUnsignedFirstIndexReturnsNilWhenValueIsNotPresent() {
        // Arrange
        let array = (0 ..< 100).map({ "Value \($0)" })

        let searchedValue = 104

        // Act
        let foundIndex = array.unsignedFirstIndex(of: "Value \(searchedValue)")

        // Assert
        XCTAssertNil(foundIndex)
    }

    func testRemovingElementWhenIsPresent() {
        // Arrange
        let initialCount = 100
        var array = (0 ..< initialCount).map({ "Value \($0)" })

        let elementToRemoveIndex = 23
        let elementToRemove = "Value \(elementToRemoveIndex)"

        // Act
        array.remove(element: elementToRemove)

        // Assert
        XCTAssertEqual(initialCount - 1, array.count)
        XCTAssertFalse(array.contains(elementToRemove))
    }

    func testRemovingElementWhenIsNotPresent() {
        // Arrange
        let initialCount = 100
        var array = (0 ..< initialCount).map({ "Value \($0)" })

        let elementToRemoveIndex = 112
        let elementToRemove = "Value \(elementToRemoveIndex)"

        // Act
        array.remove(element: elementToRemove)

        // Assert
        XCTAssertEqual(initialCount, array.count)
    }

    func testInitFromRepeatedClosure() {
        // Arrange
        let arrayCount = 100
        let valueRange: Range<UInt> = 0 ..< 10

        // Act
        let array = Array(producing: { UInt.random(in: valueRange) }, count: arrayCount.unsigned)

        // Assert
        XCTAssertEqual(arrayCount, array.count)
        array.forEach({
            if !$0.isWithin(valueRange) {
                XCTFail("Unexpected value: \($0) is not within \(valueRange).")
            }
        })
    }

    func testRemoveDuplicatedNeighbors() {
        // Assert
        XCTAssertEqual([true, false, true, false, true, false, true, false],
                       [true, true, false, true, false, false, false, true, false, true, true, false].removeDuplicatedNeighbors())
        XCTAssertEqual([3, 7, 5, 2, 10, 18, 2],
                       [3, 7, 5, 2, 10, 18, 2].removeDuplicatedNeighbors())
        XCTAssertEqual(["Test 1"],
                       ["Test 1", "Test 1"].removeDuplicatedNeighbors())
    }
}
