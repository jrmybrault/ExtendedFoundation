//
//  PublisherReceptionExpectation.swift
//  UsersTests
//
//  Created by Jérémy Brault on 09/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

import Combine
import Foundation
import XCTest

final class PublisherReceptionExpectation<T: Publisher>: XCTestExpectation {

    // MARK: - Properties

    private var cancellables = Set<AnyCancellable>()

    private(set) var values: [T.Output] = []

    // MARK: - Init

    init(_ publisher: T) {
        super.init(description: "Did not receive enough values.")
        
        publisher
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] value in
                    self?.values.append(value)
                    self?.fulfill()
            })
            .store(in: &cancellables)
    }
}
