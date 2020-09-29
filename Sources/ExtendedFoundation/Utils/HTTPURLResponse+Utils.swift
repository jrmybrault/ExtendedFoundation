//
//  HTTPURLResponse+Utils.swift
//  ApolloTests
//
//  Created by Jérémy Brault on 11/06/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension HTTPURLResponse {

    // MARK: - Init

    public convenience init?(url: URL, statusCode: Int) {
        self.init(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }

    // MARK: - Funcs
    
    public func statusCode() -> HTTPStatusCode {
        guard let statusCode = HTTPStatusCode(rawValue: UInt(self.statusCode)) else {
            fatalError("Could not find matching HTTPStatusCode for code \(self.statusCode).")
        }

        return statusCode
    }
}
