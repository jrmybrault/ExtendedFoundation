//
//  HTTPResultInterceptor.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 21/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public protocol HTTPResultInterceptor: AnyObject {

    var priority: UInt { get }

    func shouldIntercept(_ request: HTTPRequest) -> Bool
    func intercept(_ result: HTTPCallResult, for request: HTTPRequest)
}

extension HTTPResultInterceptor {

    public var priority: UInt {
        return UInt.min
    }

    public func shouldIntercept(_ request: HTTPRequest) -> Bool {
        return true
    }
}
