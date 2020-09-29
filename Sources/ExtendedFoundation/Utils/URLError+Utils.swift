//
//  URLError+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 23/10/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension URLError {
    
    public var isCancellation: Bool {
        return code == .cancelled
    }

    public var isNoInternetConnection: Bool {
        return code == .notConnectedToInternet
    }
}
