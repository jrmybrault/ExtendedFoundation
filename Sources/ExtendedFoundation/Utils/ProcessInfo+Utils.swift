//
//  ProcessInfo+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 22/02/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension ProcessInfo {

    public static var isUnitTesting: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
}
