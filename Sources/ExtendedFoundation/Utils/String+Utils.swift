//
//  String+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 03/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension String {

    public init(repeating character: Character, count: UInt) {
        self.init(repeating: character, count: count.signed)
    }
}

extension String {

    public var isNotEmpty: Bool {
        return !isEmpty
    }

    public func trimWhitespacesAndNewlines() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - Validation

extension String {

    public func isLongerOrEqual(to minimumLength: UInt) -> Bool {
        return count >= minimumLength
    }

    public static func isLongerOrEqual(to minimumLength: UInt, or error: @escaping Producer<Error>) -> Mapper<String, Error?> {
        return { string in
            return string.isLongerOrEqual(to: minimumLength) ? nil : error()
        }
    }

    public func isSmallerOrEqual(to maximumLength: UInt) -> Bool {
        return count <= maximumLength
    }

    public static func isSmallerOrEqual(to maximumLength: UInt, or error: @escaping Producer<Error>) -> Mapper<String, Error?> {
        return { string in
            return string.isSmallerOrEqual(to: maximumLength) ? nil : error()
        }
    }

    public func matches(_ regex: NSRegularExpression, options: NSRegularExpression.MatchingOptions = []) -> Bool {
        return regex.firstMatch(in: self, options: options, range: NSRange(location: 0, length: count)) != nil
    }

    public static func matches(_ regex: NSRegularExpression, or error: @escaping Producer<Error>) -> Mapper<String, Error?> {
        return { string in
            return string.matches(regex) ? nil : error()
        }
    }

    public func isWithin(_ strings: [String]) -> Bool {
        return strings.contains(self)
    }

    public static func isWithin(_ strings: [String], or error: @escaping Producer<Error>) -> Mapper<String, Error?> {
        return { string in
            return string.isWithin(strings) ? nil : error()
        }
    }
}

// MARK: - Optional

extension Optional where Wrapped == String {

    public var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }

    public var isNorEmptyNorNil: Bool {
        return self?.isNotEmpty ?? false
    }
}
