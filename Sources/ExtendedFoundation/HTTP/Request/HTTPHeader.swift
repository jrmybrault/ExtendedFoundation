//
//  HTTPHeaderKey.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 16/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public enum HTTPHeader: Equatable {
    
    case accept(MimeType)
    case acceptEncoding(String)
    case authorization(HTTPAuthorizationType)
    case cacheControl(String)
    case contentLength(UInt)
    case contentType(MimeType)
    case cookie(String)
    case userAgent(String)

    case custom(String, String)

    // MARK: - Funcs
    
    public var key: String {
        let name: String
        
        switch self {
        case .accept: name = "Accept"
        case .acceptEncoding: name = "Accept-Encoding"
        case .authorization: name = "Authorization"
        case .cacheControl: name = "Cache-Control"
        case .contentLength: name = "Content-Length"
        case .contentType: name = "Content-Type"
        case .cookie: name = "Cookie"
        case .userAgent: name = "User-Agent"
        case let .custom(aName, _): name = aName
        }
        
        return name
    }
    
    public var value: String {
        let value: String
        
        switch self {
        case let .accept(mimeType): value = mimeType.description
        case let .acceptEncoding(encoding): value = encoding
        case let .authorization(authorizationType): value = authorizationType.value
        case let .cacheControl(control): value = control
        case let .contentLength(length): value = String(length)
        case let .contentType(mimeType): value = mimeType.description
        case let .cookie(cookie): value = cookie
        case let .userAgent(name): value = name
        case let .custom(_, aValue): value = aValue
        }
        
        return value
    }

    public var fullValue: String {
        return "\(key) \(value)"
    }
}

public enum HTTPAuthorizationType: Equatable {

    case bearer(String)

    // MARK: - Funcs

    var value: String {
        switch self {
        case let .bearer(token): return "Bearer \(token)"
        }
    }
}
