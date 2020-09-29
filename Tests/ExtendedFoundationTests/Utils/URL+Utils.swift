//
//  URL+Utils.swift
//  UsersTests
//
//  Created by Jérémy Brault on 05/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension URL {

    static var fakeURL: URL {
        // swiftlint:disable force_unwrapping
        return URL(string: "http://fakeurl.com")!
        // swiftlint:enable force_unwrapping
    }
}
