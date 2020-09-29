//
//  HTTPCallResult+Description.swift
//  ExtendedFoundation
//
//  Created by JBR on 20/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension HTTPCallResult: CustomDebugStringConvertible {

    public var debugDescription: String {
        switch self {
        case let .success(response): return successDebugDescription(response: response)
        case let .failure(error):
            guard case let .some(.other(httpResponse, _, _)) = error as? HTTPError,
                let uwpHttpResponse = httpResponse else {
                    return "Response: \(error.localizedDescription)"
            }
            return "Response: \(uwpHttpResponse)"
        }
    }

    private func successDebugDescription(response: HTTPCallResponse) -> String {
        var description = "Response: \(response.httpResponse)"

        if let data = response.data,
            let dataString = String(data: data, encoding: .utf8) {

            description.append("\nData: \(dataString)")
        }

        return description
    }
}
