//
//  ChangeSet.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 02/01/2020.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public struct ChangeSet: Equatable {

    // MARK: - Properties

    public let creationIndexes: [UInt]
    public let updateIndexes: [UInt]
    public let deletionIndexes: [UInt]

    public static var empty: ChangeSet {
        ChangeSet()
    }
    
    // MARK: - Init

    public init(creationIndexes: [UInt] = [], updateIndexes: [UInt] = [], deletionIndexes: [UInt] = []) {
        self.creationIndexes = creationIndexes
        self.updateIndexes = updateIndexes
        self.deletionIndexes = deletionIndexes
    }
}

public protocol ObservableChangeSet {

    func startObserving(onChange: @escaping Consumer<ChangeSet>)
    func stopObserving()
}
