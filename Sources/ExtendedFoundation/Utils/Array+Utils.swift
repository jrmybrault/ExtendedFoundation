//
//  Array+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 23/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension Array {

    public subscript(index: UInt) -> Iterator.Element {
        return self[Int(index)]
    }
}

// MARK: - Equatable

extension Array where Element: Equatable {

    public func unsignedFirstIndex(of element: Element) -> UInt? {
        return firstIndex(of: element).map({ UInt($0) })
    }

    public mutating func remove(element: Element) {
        removeAll(where: { $0 == element })
    }
}

// MARK: - Init

extension Array {

    public init(producing: Producer<Element>, count: UInt) {
        self = (0 ..< count).map({ _ in producing() })
    }
}

// MARK: - Transforming

extension Array where Element: Equatable {

    public func removeDuplicatedNeighbors() -> [Element] {
        return (0 ..< count).compactMap({ index in
            let value = self[index]

            return (index == 0 || value != self[index - 1])
                ? value
                : nil
        })
    }
}
