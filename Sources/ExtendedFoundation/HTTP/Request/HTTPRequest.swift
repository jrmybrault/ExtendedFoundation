//
//  HTTPRequest.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 10/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public typealias HTTPQueryParameters = [String: String]

public struct HTTPRequest: Equatable {
    
    // MARK: - Properties
    
    public let api: HTTPAPI

    public let identifier: String // This only serves to identify the request

    public let path: String?
    public let method: HTTPMethod
    public let isUpload: Bool

    public let queryParameters: HTTPQueryParameters
    public let bodyParameter: HTTPBodyParameter?
    
    public let headers: [HTTPHeader]
    
    // MARK: - Init
    
    public init(api: HTTPAPI,
                identifier: String,
                path: String? = nil,
                method: HTTPMethod = .get,
                isUpload: Bool = false,
                queryParameters: HTTPQueryParameters = [:],
                bodyParameter: HTTPBodyParameter? = nil,
                headers: [HTTPHeader] = []) {
        self.api = api
        self.identifier = identifier
        self.path = path
        self.method = method
        self.isUpload = isUpload
        self.queryParameters = queryParameters
        self.bodyParameter = bodyParameter
        self.headers = headers
    }
    
    public init(request: HTTPRequest, additionalQueryParameters: HTTPQueryParameters, additionalHeaders: [HTTPHeader]) {
        var queryParameters = request.queryParameters
        additionalQueryParameters.forEach({ key, value in
            queryParameters[key] = value
        })
        
        var headers = request.headers
        headers.append(contentsOf: additionalHeaders)
        
        self.init(api: request.api,
                  identifier: request.identifier,
                  path: request.path,
                  method: request.method,
                  isUpload: request.isUpload,
                  queryParameters: queryParameters,
                  bodyParameter: request.bodyParameter,
                  headers: headers)
    }

    public init?(url: URL, identifier: String, method: HTTPMethod = .get) {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let scheme = urlComponents.scheme.flatMap(HTTPScheme.init),
            let host = urlComponents.host, host.isNotEmpty else {
                return nil
        }

        let api = HTTPAPI(scheme: scheme, host: host, port: urlComponents.port, path: urlComponents.path)

        let queryParameters = urlComponents.queryItems.flatMap({
            Dictionary(uniqueKeysWithValues: $0.map({ ($0.name, $0.value ?? "") }))
        })

        self = HTTPRequest(api: api, identifier: identifier, method: method, queryParameters: queryParameters ?? [:])
    }
    
    // MARK: - Funcs
    
    public static func == (lhs: HTTPRequest, rhs: HTTPRequest) -> Bool {
        return lhs.api == rhs.api
            && lhs.identifier == rhs.identifier
            && lhs.path == rhs.path
            && lhs.method == rhs.method
            && lhs.isUpload == rhs.isUpload
            && lhs.queryParameters == rhs.queryParameters
            && lhs.bodyParameter?.mimeType == rhs.bodyParameter?.mimeType
            && lhs.bodyParameter?.data == rhs.bodyParameter?.data
            && lhs.headers == rhs.headers
    }
}
