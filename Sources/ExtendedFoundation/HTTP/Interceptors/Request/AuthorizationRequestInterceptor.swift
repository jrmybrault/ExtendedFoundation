//
//  AuthorizationRequestInterceptor.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 20/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public final class AuthorizationRequestInterceptor: HTTPRequestInterceptor {

    // MARK: - Properties

    public var authorization: String?

    public let priority = UInt.max
    
    // MARK: - Init

    public init(authorization: String? = nil) {
        self.authorization = authorization
    }

    // MARK: - Funcs

    public func intercept(_ request: HTTPRequest) -> HTTPRequest {
        guard let authorization = authorization else {
            return request
        }

        return HTTPRequest(request: request,
                           additionalQueryParameters: [:],
                           additionalHeaders: [.authorization(.bearer(authorization))])
    }
}
