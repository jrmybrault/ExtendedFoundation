//
//  NonOptionalField.swift
//  ExtendedFoundation
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

import Combine
import Foundation

@propertyWrapper
public class NonOptionalField<Value: Equatable>: Validable {

    // MARK: - Properties

    public var wrappedValue: Value {
        didSet {
            if wrappedValue != oldValue {
                valueChangeConsumers.values.forEach({ $0(wrappedValue) })

                validate()
            }
        }
    }
    private var valueChangeConsumers = [ObservingToken: Consumer<Value>]()

    private let undefinedErrorBlock: Producer<Error?>
    private let validationErrorBlock: Mapper<Value, Error?>
    private var dynamicValidationErrorBlocks = [Mapper<Value, Error?>]()
    private var validationChangeConsumers = [ObservingToken: Consumer<Error?>]()

    public var projectedValue: NonOptionalField {
        self
    }

    // MARK: - Init

    public init(_ initialValue: Value,
                undefinedError: @escaping Producer<Error?> = { nil },
                validationError: @escaping Mapper<Value, Error?> = { _ in nil }) {
        self.wrappedValue = initialValue

        self.undefinedErrorBlock = undefinedError
        self.validationErrorBlock = validationError

        validate()
    }

    public func observeValueChange(_ observer: @escaping Consumer<Value>) -> ObservingToken {
        let observingToken = ObservingToken()
        valueChangeConsumers[observingToken] = observer

        return observingToken
    }

    public func removeValueChangeObserver(matching token: ObservingToken) {
        valueChangeConsumers.removeValue(forKey: token)
    }

    public func validationError() -> Error? {
        let error: Error?

        // Here we manage a special case for String where "" is also considered as undefined
        let valueIsNotAnEmptyString = (wrappedValue as? String)?.isNotEmpty ?? true

        if valueIsNotAnEmptyString {
            error = validationErrorBlock(wrappedValue) ?? dynamicValidationErrorBlocks.compactMap({ $0(wrappedValue) }).first
        } else if let undefinedError = undefinedErrorBlock() {
            error = undefinedError
        } else {
            error = nil
        }

        return error
    }

    public func addValidationError(_ validationError: @escaping Mapper<Value, Error?>) {
        dynamicValidationErrorBlocks.append(validationError)

        validate()
    }

    public func observeValidationChange(_ observer: @escaping Consumer<Error?>) -> ObservingToken {
        let observingToken = ObservingToken()
        validationChangeConsumers[observingToken] = observer

        return observingToken
    }

    public func removeValidationChangeObserver(matching token: ObservingToken) {
        validationChangeConsumers.removeValue(forKey: token)
    }

    private func validate() {
        validationChangeConsumers.values.forEach({ $0(validationError()) })
    }
}

extension NonOptionalField {

    public var onValueChangeObservable: AnyPublisher<Value, Never> {
        let observable = CurrentValueSubject<Value, Error>(wrappedValue)
        let observingToken = observeValueChange({ value in
            observable.send(value)
        })

        return observable
            .handleEvents(receiveCancel: { [weak self] in
                self?.removeValueChangeObserver(matching: observingToken)
            })
            .removeDuplicates()
            .assertNoFailure()
            .eraseToAnyPublisher()
    }

    public var onValidationChangeObservable: AnyPublisher<Error?, Never> {
        let observable = CurrentValueSubject<Error?, Error>(validationError())
        let observingToken = observeValidationChange({ error in
            observable.send(error)
        })

        return observable
            .handleEvents(receiveCancel: { [weak self] in
                self?.removeValidationChangeObserver(matching: observingToken)
            })
            .assertNoFailure()
            .eraseToAnyPublisher()
    }
}
