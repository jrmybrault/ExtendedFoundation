//
//  NSRegularExpression+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 21/03/2020.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension NSRegularExpression {
    
    public static var email: NSRegularExpression {
        // swiftlint:disable line_length
        let pattern = "^(([^<>()\\[\\]\\\\.,;:\\s@\"]+(\\.[^<>()\\[\\]\\\\.,;:\\s@\"]+)*)|(\".+\"))@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}])|(([A-Z\\-0-9]+\\.)+[A-Z]+))$"
        // swiftlint:enable line_length
        
        // swiftlint:disable force_try
        return try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        // swiftlint:enable force_try
    }
}
