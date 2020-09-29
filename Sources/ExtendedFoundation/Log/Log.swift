//
//  Log.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 28/08/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public func printDebug(_ items: Any ..., type: DebugPrintType = .default, separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print("\(type.prefix) \(items) \(type.appendix)", separator: separator, terminator: terminator)
    #endif
}
