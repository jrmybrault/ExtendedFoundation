//
//  Percentage.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 16/04/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public struct Percentage {

    // MARK: - Properties

    public let value: UInt

    // MARK: - Init

    /// - Precondition: `value` must be between 0 and 100 included.
    public init(_ value: UInt) {
        precondition((0 ... 100).contains(value), "\(value) is not a valid value for a percentage.")

        self.value = value
    }

    // MARK: - Funcs

    public var double: Double {
        Double(value) / 100.0
    }
}
