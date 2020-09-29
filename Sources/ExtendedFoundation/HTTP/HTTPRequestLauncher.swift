//
//  HTTPRequestLauncher.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 28/08/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public protocol HTTPRequestLauncher {

    @discardableResult
    func launch(_ request: HTTPRequest, onResult: @escaping Consumer<HTTPCallResult>) -> CancellableTask
}
