//
//  HTTPError.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 23/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public enum HTTPError: Error, Equatable {

    case cancelled
    case noInternetConnection
    case other(HTTPURLResponse?, URLError?, Data?)
}

public struct HTTPUnexpectedEmptyDataError: Error {
}

public struct HTTPDataDecodingError: Error {

    // MARK: - Properties

    public let data: Data?
    public let rootError: Error?

    // MARK: - Public

    init(data: Data?, rootError: Error?) {
        self.data = data
        self.rootError = rootError
    }
}
