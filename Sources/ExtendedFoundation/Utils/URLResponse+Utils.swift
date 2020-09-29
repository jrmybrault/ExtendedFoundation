//
//  URLResponse+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 21/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension URLResponse {

    public func mimeType() -> MimeType? {
        guard let mimeType = mimeType else { return nil }

        let splittedMimeType = mimeType.split(separator: ";", maxSplits: 2, omittingEmptySubsequences: false)

        guard let category = MimeType.Category(rawValue: String(splittedMimeType[0])) else { return nil }

        let parameter: (key: String, value: String)?

        if splittedMimeType.count > 1 {
            let splittedParameter = splittedMimeType[1].split(separator: "=", maxSplits: 2, omittingEmptySubsequences: false)

            // Don't forget to trim potential space before the parameter name
            parameter = (key: String(splittedParameter[0]).trimWhitespacesAndNewlines(), value: String(splittedParameter[1]))
        } else {
            parameter = nil
        }

        return MimeType(category, parameter: parameter)
    }
}
