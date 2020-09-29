//
//  Collection+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 03/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension Collection {

    public subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }

    public var unsignedCount: UInt {
        return UInt(count)
    }

    public var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension Collection where Element: Equatable {

    public func indexDistance(of element: Element) -> Int? {
        guard let index = firstIndex(of: element) else { return nil }
        return distance(from: startIndex, to: index)
    }
}
