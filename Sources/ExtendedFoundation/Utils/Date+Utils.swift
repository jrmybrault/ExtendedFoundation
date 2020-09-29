//
//  Date+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 28/11/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

// MARK: - Creation

extension Date {

    public static var now: Date {
        return Date()
    }

    public static var today: Date {
        return Date()
    }

    public var dayBefore: Date {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: self) else {
            fatalError("Could not instantiate yesterday.")
        }

        return yesterday
    }

    public static var yesterday: Date {
        return today.dayBefore
    }

    public var dayAfter: Date {
        guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: self) else {
            fatalError("Could not instantiate yesterday.")
        }

        return tomorrow
    }

    public static var tomorrow: Date {
        return today.dayAfter
    }
}

// MARK: - Components

extension Date {

    public var day: UInt {
        return Calendar.current.component(.day, from: self).unsigned
    }

    public var month: UInt {
        return Calendar.current.component(.month, from: self).unsigned
    }

    public var year: UInt {
        return Calendar.current.component(.year, from: self).unsigned
    }
}

// MARK: - Computation

extension Date {

    /// - Precondition: `date` must be anterior to `self`.
    public func numberOfYearsSince(_ date: Date) -> UInt {
        precondition(self >= date, "Cannot compute number of years with the posterior date \(date).")

        let ageComponents = Calendar.current.dateComponents([.year], from: date, to: self)

        guard let numberOfYears = ageComponents.year?.unsigned else {
            fatalError("Could not compute number of years since \(date).")
        }

        return numberOfYears
    }

    public static func numberOfYearsSince(_ date: Date) -> UInt {
        return now.numberOfYearsSince(date)
    }

    public func plus(dateComponent: Calendar.Component, value: Int) -> Date {
        guard let date = Calendar.current.date(byAdding: dateComponent, value: value, to: self) else {
            fatalError("Could not compute new date from \(self) + \(value) \(dateComponent)")
        }

        return date
    }
}

// MARK: - Validation

extension Date {

    public func isBefore(_ date: Date) -> Bool {
        return self < date
    }

    public func isAfter(_ date: Date) -> Bool {
        return self > date
    }

    public func isWithin(_ range: ClosedRange<Date>) -> Bool {
        return range ~= self
    }

    public static func isWithin(_ range: ClosedRange<Date>, or error: @escaping Producer<Error>) -> Mapper<Date, Error?> {
        return { date in
            return date.isWithin(range) ? nil : error()
        }
    }
}
