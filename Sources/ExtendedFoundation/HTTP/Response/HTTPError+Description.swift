//
//  HTTPError+Description.swift
//  ExtendedFoundation
//
//  Created by JBR on 20/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension HTTPError: CustomStringConvertible {

    public var description: String {
        let description: String

        switch self {
        case .cancelled: description = "The task has been cancelled."
        case .noInternetConnection: description = "There is no active internet connection."
        case let .other(response, error, data):
            var otherDescription = ""

            if let statusCode = response?.statusCode() {
                otherDescription.append("An HTTP error occured with status: \(statusCode)")
            } else {
                otherDescription.append("An unknown HTTP error occured: \(String(describing: error))")
            }
            if let uwpData = data {
                otherDescription.append(" data: \(String(data: uwpData, encoding: .utf8) ?? "")")
            }
            description = otherDescription
        }

        return description
    }
}

extension HTTPUnexpectedEmptyDataError: CustomStringConvertible {
    
    public var description: String {
        return "A response body was expected but it was empty."
    }
}

extension HTTPDataDecodingError: CustomStringConvertible {

    public var description: String {
        return "The response body decoding failed with error: \(String(describing: rootError))."
    }
}
