//
//  Sequence+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 25/11/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension Sequence {

    public func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}
