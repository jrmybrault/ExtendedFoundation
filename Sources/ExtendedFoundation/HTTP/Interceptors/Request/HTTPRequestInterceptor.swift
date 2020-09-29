//
//  Interceptor.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 20/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public protocol HTTPRequestInterceptor: AnyObject {

    var priority: UInt { get }

    func intercept(_ request: HTTPRequest) -> HTTPRequest
}

extension HTTPRequestInterceptor {

    public var priority: UInt {
        return UInt.min
    }
}
