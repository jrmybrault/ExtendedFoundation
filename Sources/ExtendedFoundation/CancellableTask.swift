//
//  CancellableTask.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 28/06/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public protocol CancellableTask {

    func cancel()

    var isCancelled: Bool { get }
}

public final class CleanTask: CancellableTask {

    // MARK: - Properties

    public private(set) var isCancelled: Bool = false

    // MARK: - Init

    public init() {
    }

    // MARK: - Funcs
    
    public func cancel() {
        isCancelled = true
    }
}
