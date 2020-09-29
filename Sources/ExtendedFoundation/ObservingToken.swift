//
//  ObservingToken.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 23/11/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public class ObservingToken: Equatable, Hashable {

    // MARK: - Properties

    private let key = UUID().uuidString

    // MARK: - Init

    public init() {
    }

    // MARK: - Funcs

    public static func == (lhs: ObservingToken, rhs: ObservingToken) -> Bool {
        lhs.key == rhs.key
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(key)
    }
}
