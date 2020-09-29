//
//  UserAgentRequestInterceptor.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 20/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public final class UserAgentRequestInterceptor: HTTPRequestInterceptor {

    // MARK: - Properties

    private let userAgent: String

    // MARK: - Init

    public init(userAgent: String) {
        self.userAgent = userAgent
    }

    // MARK: - Funcs

    public func intercept(_ request: HTTPRequest) -> HTTPRequest {
        return HTTPRequest(request: request,
                           additionalQueryParameters: [:],
                           additionalHeaders: [.userAgent(userAgent)])
    }
}
