//
//  Result+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 26/03/2020.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension Result {

    public var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }

    public var isFailure: Bool {
        return !isSuccess
    }
}
