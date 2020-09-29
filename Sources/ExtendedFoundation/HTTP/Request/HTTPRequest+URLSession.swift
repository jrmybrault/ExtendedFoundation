//
//  HTTPRequest+URLSession.swift
//  ExtendedFoundation
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension HTTPRequest {

    public var url: URL {
        var components = api.urlComponents
        path.flatMap({ components.path.append($0) })

        components.queryItems = queryParameters.map(URLQueryItem.init)
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        guard let url = components.url else { fatalError("Could not build URL with components \(components).") }

        return url
    }

    public var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue

        var requestHeaders = headers

        if let bodyParameter = bodyParameter {
            if let bodyData = bodyParameter.data {
                urlRequest.httpBody = bodyData

                requestHeaders.append(.contentType(bodyParameter.mimeType))
                requestHeaders.append(.contentLength(UInt(bodyData.count)))
            }
        }

        requestHeaders.forEach({ urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) })

        return urlRequest
    }
}
