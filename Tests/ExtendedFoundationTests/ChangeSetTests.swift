//
//  ChangeSetTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class ChangeSetTests: XCTestCase {

    // MARK: - Funcs

    func testEmptyChangeSetHasNoCreationUpdateOrDeletionIndexes() {
        // Act
        let emptyChangeSet = ChangeSet.empty

        // Assert
        XCTAssertTrue(emptyChangeSet.creationIndexes.isEmpty)
        XCTAssertTrue(emptyChangeSet.updateIndexes.isEmpty)
        XCTAssertTrue(emptyChangeSet.deletionIndexes.isEmpty)
    }
}
