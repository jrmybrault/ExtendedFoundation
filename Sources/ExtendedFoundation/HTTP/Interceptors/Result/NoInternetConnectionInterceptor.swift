//
//  NoInternetConnectionInterceptor.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 21/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public final class NoInternetConnectionInterceptor: HTTPResultInterceptor {

    // MARK: - Properties

    public var callback: Runnable?

    public let excludeRequestIdentifiers: [String]

    // MARK: - Init

    public init(callback: Runnable? = nil, excludeRequestIdentifiers: [String] = []) {
        self.callback = callback

        self.excludeRequestIdentifiers = excludeRequestIdentifiers
    }

    // MARK: - Funcs

    public func shouldIntercept(_ request: HTTPRequest) -> Bool {
        return !excludeRequestIdentifiers.contains(request.identifier)
    }

    public func intercept(_ result: HTTPCallResult, for request: HTTPRequest) {
        if case let .failure(error) = result,
            let urlError = error as? HTTPError, urlError == .noInternetConnection {

            callback?()
        }
    }
}
