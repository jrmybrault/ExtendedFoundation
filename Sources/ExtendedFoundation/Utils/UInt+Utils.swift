//
//  UInt+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 31/12/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension UInt {

    public var signed: Int {
        return Int(self)
    }
}

// MARK: - Comparison

extension UInt {

    public func isWithin(_ range: Range<UInt>) -> Bool {
        return range.contains(self)
    }
}
