//
//  Validable.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 12/03/2020.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public protocol Validable {

    func validationError() -> Error?

    func observeValidationChange(_ observer: @escaping Consumer<Error?>) -> ObservingToken
}

extension Validable {

    public var isValid: Bool {
        return validationError() == nil
    }
}
