//
//  Bool+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 15/03/2020.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension Bool {

    public static func isTrue(or error: @escaping Producer<Error>) -> Mapper<Bool, Error?> {
        return { value in
            return value ? nil : error()
        }
    }

    public static func isFalse(or error: @escaping Producer<Error>) -> Mapper<Bool, Error?> {
        return { value in
            return value ? error() : nil
        }
    }
}
