//
//  NonOptionalFieldTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class NonOptionalFieldTests: XCTestCase {

    fileprivate enum FieldError: Error, Equatable {

        case undefined
        case invalid
        case dynamic1
        case dynamic2
    }

    // MARK: - Constants

    fileprivate enum Constants {
        static let minimumLength: UInt = 5
    }

    // MARK: - SUT

    @NonOptionalField("initialValue",
                      undefinedError: { FieldError.undefined },
                      validationError: String.isLongerOrEqual(to: Constants.minimumLength, or: { FieldError.invalid }))
    private var validatedField: String

    @NonOptionalField("initialValue")
    private var unvalidatedField: String

    // MARK: - Funcs

    override func tearDown() {
        super.tearDown()

        validatedField = ""
        unvalidatedField = ""
    }

    func testSetInitialValue() {
        // Assert
        XCTAssertEqual("initialValue", validatedField)
    }

    func testNotifyValueChangeWhenObserving() {
        // Arrange
        let valueChanges = ["valid test 1", "t", "", "valid test 2", "valid test 2", ""]
        let expectedReceivedValues = valueChanges.removeDuplicatedNeighbors()

        var observedValues = [String?]()

        _ = $validatedField.observeValueChange {
            observedValues.append($0)
        }

        // Act
        valueChanges.forEach({ validatedField = $0 })

        // Assert
        XCTAssertEqual(expectedReceivedValues, observedValues)
    }

    func testPublishValueChangeWhenObserving() {
        // Arrange
        let valueChanges = ["valid test 1", "t", "", "valid test 2", "valid test 2", ""]
        let expectedReceivedValues = [$validatedField.wrappedValue] + valueChanges.removeDuplicatedNeighbors() // Add the initial value

        let receptionExpectation = PublisherReceptionExpectation($validatedField.onValueChangeObservable)
        receptionExpectation.expectedFulfillmentCount = expectedReceivedValues.count

        // Act
        valueChanges.forEach({ validatedField = $0 })

        // Assert
        wait(for: [receptionExpectation], timeout: TestConstants.defaultExpectationTimeout)

        XCTAssertEqual(expectedReceivedValues, receptionExpectation.values)
    }

    func testDoNotNotifyValueChangeWhenStoppingObserving() {
        // Arrange
        let valueChanges = ["valid test 1", "t", "", "valid test 2", "valid test 2", ""]

        var observedValues = [String?]()

        let observingToken = $validatedField.observeValueChange {
            observedValues.append($0)
        }

        $validatedField.removeValueChangeObserver(matching: observingToken)

        // Act
        valueChanges.forEach({ validatedField = $0 })

        // Assert
        XCTAssertTrue(observedValues.isEmpty)
    }

    func testNoUndefinedOrValidationErrorByDefault() {
        // Arrange
        let valueChanges = ["valid test 1", "t", "", "valid test 2", "valid test 2", ""]
        // The second "valid test 2" should not trigger any validation change because the value didn't change
        let expectedReceivedValues: [FieldError?] = [nil, nil, nil, nil, nil]

        var observedValues = [FieldError?]()

        _ = $unvalidatedField.observeValidationChange {
            observedValues.append($0 as? FieldError)
        }

        // Act
        valueChanges.forEach({ unvalidatedField = $0 })

        // Assert
        XCTAssertEqual(expectedReceivedValues, observedValues)
    }

    func testNotifyErrorChangeWhenObserving() {
        // Arrange
        let valueChanges = ["valid test 1", "t", "", "valid test 2", "valid test 2", ""]
        // The second "valid test 2" should not trigger any validation change because the value didn't change
        let expectedReceivedValues = [nil, FieldError.invalid, FieldError.undefined, nil, FieldError.undefined]

        var observedValues = [FieldError?]()

        _ = $validatedField.observeValidationChange {
            observedValues.append($0 as? FieldError)
        }

        // Act
        valueChanges.forEach({ validatedField = $0 })

        // Assert
        XCTAssertEqual(expectedReceivedValues, observedValues)
    }

    func testPublishErrorChangeWhenObserving() {
        // Arrange
        let valueChanges = ["valid test 1", "t", "", "valid test 2", "valid test 2", ""]
        // The second "valid test 2" should not trigger any validation change because the value didn't change
        let expectedReceivedValues = [$validatedField.validationError() as? FieldError, // Add initial value
                                      nil, FieldError.invalid, FieldError.undefined, nil, FieldError.undefined]

        let receptionExpectation = PublisherReceptionExpectation($validatedField.onValidationChangeObservable)
        receptionExpectation.expectedFulfillmentCount = expectedReceivedValues.count

        // Act
        valueChanges.forEach({ validatedField = $0 })

        // Assert
        wait(for: [receptionExpectation], timeout: TestConstants.defaultExpectationTimeout)

        XCTAssertEqual(expectedReceivedValues, receptionExpectation.values.map({ $0 as? FieldError }))
    }

    func testNotifyErrorChangeWithDynamicErrorWhenObserving() {
        // Arrange
        let valueChanges = ["valid test 1", "t", "invalid test 1", "", "valid test 2", "valid test 2", "invalid test 2", ""]
        // The second "valid test 2" should not trigger any validation change because the value didn't change
        let expectedReceivedValues = [nil, FieldError.invalid, FieldError.dynamic1, FieldError.undefined, nil, FieldError.dynamic2, FieldError.undefined]

        $validatedField.addValidationError(String.isWithin(["valid test 1", "valid test 2", "invalid test 2"], or: { FieldError.dynamic1 }))
        $validatedField.addValidationError(String.isSmallerOrEqual(to: 13, or: { FieldError.dynamic2 }))

        var observedValues = [FieldError?]()

        _ = $validatedField.observeValidationChange {
            observedValues.append($0 as? FieldError)
        }

        // Act
        valueChanges.forEach({ validatedField = $0 })

        // Assert
        XCTAssertEqual(expectedReceivedValues, observedValues)
    }

    func testDoNotNotifyErrorChangeWhenStoppingObserving() {
        // Arrange
        let valueChanges = ["valid test 1", "t", "", "valid test 2", "valid test 2", ""]

        var observedValues = [Error?]()

        let observingToken = $validatedField.observeValidationChange {
            observedValues.append($0)
        }

        $validatedField.removeValidationChangeObserver(matching: observingToken)

        // Act
        valueChanges.forEach({ validatedField = $0 })
        
        // Assert
        XCTAssertTrue(observedValues.isEmpty)
    }
}
