//
//  CollectionUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class CollectionUtilsTests: XCTestCase {

    // MARK: - Funcs

    func testSafeSubscriptIsEqualToRegularSubscriptWhenElementIsPresent() {
        // Arrange
        let array = (0 ..< 100)

        let searchedIndex = 88

        // Assert
        XCTAssertEqual(array[searchedIndex], array[safe: searchedIndex])
    }

    func testSafeSubscriptReturnsNilWhenElementIsNotPresent() {
        // Arrange
        let array = (0 ..< 100)

        let searchedIndex = 101

        // Assert
        XCTAssertNil(array[safe: searchedIndex])
    }

    func testUnsignedCountIsEqualToSignedCount() {
        // Arrange
        let emptyArray = [String]()
        let oneElementArray = ["test"]
        let multipleElementsArray = ["test1", "test2", "test3", "test4"]

        // Assert
        XCTAssertEqual(emptyArray.count, emptyArray.unsignedCount.signed)
        XCTAssertEqual(oneElementArray.count, oneElementArray.unsignedCount.signed)
        XCTAssertEqual(multipleElementsArray.count, multipleElementsArray.unsignedCount.signed)
    }

    func testIsNotEmptyIsEqualToNotIsEmpty() {
        // Arrange
        let emptyArray = [String]()
        let oneElementArray = ["test"]
        let multipleElementsArray = ["test1", "test2", "test3", "test4"]

        // Assert
        XCTAssertEqual(!emptyArray.isEmpty, emptyArray.isNotEmpty)
        XCTAssertEqual(!oneElementArray.isEmpty, oneElementArray.isNotEmpty)
        XCTAssertEqual(!multipleElementsArray.isEmpty, multipleElementsArray.isNotEmpty)
    }

    func testIndexDistanceOfElementReturnsDistanceBetweenStartIndexAndElementIndexOnlyWhenElementIsPresent() {
        // Arrange
        let array = (0 ..< 100).map({ "test\($0)" })
        let slicingIndex = 23
        let firstSlice = array.prefix(upTo: slicingIndex)
        let secondSlice = array.suffix(from: slicingIndex)

        let searchedElementIndex = 67
        let searchedElement = array[searchedElementIndex]

        // Assert
        XCTAssertNil(firstSlice.indexDistance(of: searchedElement))
        XCTAssertEqual(searchedElementIndex - slicingIndex, secondSlice.indexDistance(of: searchedElement))
    }
}
