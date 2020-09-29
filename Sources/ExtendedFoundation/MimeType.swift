//
//  MimeType.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 20/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public struct MimeType {

    public enum Category: String {

        case textHtml = "text/html"
        case json = "application/json"
        case bytes = "application/octet-stream"
        case pngImage = "image/png"
        case jpegImage = "image/jpeg"
        case multipartFormData = "multipart/form-data"

        var description: String {
            return rawValue
        }
    }

    // MARK: - Properties

    let category: Category
    let parameter: (key: String, value: String)?

    // MARK: - Init

    public init(_ category: MimeType.Category, parameter: (key: String, value: String)? = nil) {
        self.category = category
        self.parameter = parameter
    }

    public var description: String {
        if let parameter = parameter {
            return "\(category.description); \(parameter.key)=\(parameter.value)"
        } else {
            return category.description
        }
    }
}

extension MimeType: Equatable {

    public static func == (lhs: MimeType, rhs: MimeType) -> Bool {
        lhs.description == rhs.description
    }
}
