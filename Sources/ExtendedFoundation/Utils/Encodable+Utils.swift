//
//  Encodable+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 28/08/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension Encodable {

    func jsonData(using encoder: JSONEncoder = JSONEncoder()) -> Data? {
        do {
            return try encoder.encode(self)
        } catch {
            printDebug("Failed to encode to JSON: \(self).", type: .error(error))

            return nil
        }
    }
}
