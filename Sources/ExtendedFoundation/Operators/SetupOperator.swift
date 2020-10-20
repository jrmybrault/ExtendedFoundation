//
//  SetupOperator.swift
//  
//
//  Created by Jérémy Brault on 20/10/2020.
//

import Foundation

prefix operator =>
infix operator => : MultiplicationPrecedence

@discardableResult
public prefix func => <T>(setup: () -> T) -> T {
    setup()
}

@discardableResult
public func => <T>(object: T, setup: (inout T) -> Void) -> T {
    var object = object
    setup(&object)
    return object
}
