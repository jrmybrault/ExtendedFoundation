//
//  HTTPRequest+Description.swift
//  ExtendedFoundation
//
//  Created by JBR on 20/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension HTTPRequest: CustomDebugStringConvertible {

    public var debugDescription: String {
        var description = "Request: \(method.rawValue.uppercased()) \(url)"
        description.append("\nHeaders: \(headers)")

        if let bodyData = bodyParameter?.data,
            let bodyString = String(data: bodyData, encoding: .utf8) {

            description.append("\nData: \(bodyString)")
        }

        return description
    }
}
