//
//  SequenceUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 16/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class SequenceUtilsTests: XCTestCase {

    fileprivate enum Job: UInt, Comparable {

        case musician
        case actor
        case politician

        static func < (lhs: Job, rhs: Job) -> Bool {
            return lhs.rawValue > rhs.rawValue
        }
    }

    // MARK: - Funcs

    func testSortingByKeyPath() {
        // Arrange
        struct Person: Equatable {

            let name: String
            let age: UInt

            let job: Job
        }

        let persons = [Person(name: "Didier Barbelivien", age: 66, job: .musician),
                       Person(name: "Charles Aznavour", age: 94, job: .musician),
                       Person(name: "Marlon Brando", age: 80, job: .actor),
                       Person(name: "Jean-Jacques Goldman", age: 68, job: .musician),
                       Person(name: "Elvis Prestley", age: 42, job: .musician),
                       Person(name: "Keira Knightley", age: 35, job: .actor),
                       Person(name: "Jean-Claude Van Damme", age: 59, job: .actor),
                       Person(name: "Jacques Chirac", age: 86, job: .politician)]

        // Act
        let sortedByNamePersons = persons.sorted(by: \.name)
        let sortedByAgePersons = persons.sorted(by: \.age)
        let sortedByJobPersons = persons.sorted(by: \.job)

        // Assert
        XCTAssertEqual(persons.sorted(by: { $0.name < $1.name }), sortedByNamePersons)
        XCTAssertEqual(persons.sorted(by: { $0.age < $1.age }), sortedByAgePersons)
        XCTAssertEqual(persons.sorted(by: { $0.job < $1.job }), sortedByJobPersons)
    }
}
