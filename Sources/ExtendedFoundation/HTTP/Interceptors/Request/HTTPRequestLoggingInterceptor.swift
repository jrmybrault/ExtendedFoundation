//
//  HTTPRequestLoggingInterceptor.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 30/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public final class HTTPRequestLoggingInterceptor: HTTPRequestInterceptor {

    // MARK: - Properties

    public let priority = UInt.min
    
    // MARK: - Init

    public init() {
    }

    // MARK: - Funcs

    public func intercept(_ request: HTTPRequest) -> HTTPRequest {
        printDebug(request)

        return request
    }
}
