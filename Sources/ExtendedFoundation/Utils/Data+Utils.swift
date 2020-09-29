//
//  Data+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 18/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension Data {

    public struct HexEncodingOptions: OptionSet {

        public let rawValue: Int

        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)

        // MARK: - Init

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }

    // MARK: - Funcs

    public init?(unpaddedBase64Encoded: String) {
        let stringLength = unpaddedBase64Encoded.count
        let padLength = stringLength + (4 - (stringLength % 4)) % 4
        let paddedString = unpaddedBase64Encoded.padding(toLength: padLength, withPad: "=", startingAt: 0)

        if let data = Data(base64Encoded: paddedString) {
            self = data
        } else {
            return nil
        }
    }

    public init?(base64URLEncoded string: String) {
        let base64String = string.replacingOccurrences(of: "_", with: "/")
            .replacingOccurrences(of: "-", with: "+")

        let base64StringLength = base64String.count
        let padLength = base64StringLength + (4 - (base64StringLength % 4)) % 4
        let paddedString = base64String.padding(toLength: padLength, withPad: "=", startingAt: 0)

        if let data = Data(base64Encoded: paddedString) {
            self = data
        } else {
            return nil
        }
    }

    public func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let hexDigits = Array((options.contains(.upperCase) ? "0123456789ABCDEF" : "0123456789abcdef").utf16)

        var chars: [unichar] = []
        chars.reserveCapacity(2 * count)

        for byte in self {
            chars.append(hexDigits[Int(byte / 16)])
            chars.append(hexDigits[Int(byte % 16)])
        }

        return String(utf16CodeUnits: chars, count: chars.count)
    }

    public mutating func append(_ string: String, encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            append(data)
        }
    }
}
