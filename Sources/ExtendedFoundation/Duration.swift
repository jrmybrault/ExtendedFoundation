//
//  Duration.swift
//  OpenKit
//
//  Created by Jérémy Brault on 27/12/2018.
//  Copyright © 2018 Open. All rights reserved.
//

import Foundation

public struct Duration: Equatable {

    public enum Unit: Double, Equatable {

        case millisecond = 1
        case decisecond = 10
        case centisecond = 100
        case second = 1000
        case minute = 60_000
        case hour = 3_600_000
        case day = 86_400_000
        case week = 604_800_000
    }

    // MARK: - Properties

    public let value: Double
    public let unit: Unit

    // MARK: - Init

    public init(_ value: Double, _ unit: Unit) {
        self.value = value
        self.unit = unit
    }

    // MARK: - Funcs

   public func `in`(_ unit: Unit) -> Double {
        value * self.unit.rawValue * (1 / unit.rawValue)
    }
}
