//
//  HTTPCallResult.swift
//  Common
//
//  Created by Jérémy Brault on 19/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public typealias HTTPCallResult = Result<HTTPCallResponse, Error>
public typealias HTTPCallDecodedResult<Value: Decodable> = Result<HTTPCallDecodedResponse<Value>, Error>

extension HTTPCallResult {

    public var statusCode: HTTPStatusCode? {
        switch self {
        case let .success(response): return response.httpResponse.statusCode()
        case let .failure(error):
            guard case let .some(.other(httpResponse, _, _)) = error as? HTTPError,
                let uwpHttpResponse = httpResponse else {
                    return nil
            }
            return uwpHttpResponse.statusCode()
        }
    }
}

public struct HTTPCallResponse: Equatable {

    // MARK: - Properties

    let httpResponse: HTTPURLResponse
    public let data: Data?

    public var statusCode: HTTPStatusCode {
        return httpResponse.statusCode()
    }

    // MARK: - Init

    public init(httpResponse: HTTPURLResponse, data: Data?) {
        self.httpResponse = httpResponse
        self.data = data
    }
}

public struct HTTPCallDecodedResponse<Value> {

    // MARK: - Properties

    let httpResponse: HTTPURLResponse
    public let value: Value

    public var statusCode: HTTPStatusCode {
        return httpResponse.statusCode()
    }

    // MARK: - Init

    public init(httpResponse: HTTPURLResponse, value: Value) {
        self.httpResponse = httpResponse
        self.value = value
    }
}
