//
//  HTTPResultLoggingInterceptor.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 30/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public final class HTTPResultLoggingInterceptor: HTTPResultInterceptor {

    // MARK: - Properties

    public var priority = UInt.min
    
    // MARK: - Init

    public init() {
    }

    // MARK: - Funcs

    public func intercept(_ result: HTTPCallResult, for request: HTTPRequest) {
        switch result {
        case .success: printDebug(result)
        case let .failure(error): printDebug(result, type: .error(error))
        }
    }
}
