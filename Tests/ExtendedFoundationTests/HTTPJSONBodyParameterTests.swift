//
//  HTTPJSONBodyParameterTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 20/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class HTTPJSONBodyParameterTests: XCTestCase {

    // MARK: - Funcs

    func testDataIsEqualsToEncoder() {
        // Arrange
        struct Event: Codable {

            let name: String
            let price: Float
            let date: Date
        }

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601

        let event = Event(name: "test event", price: 105.5, date: Date())
        let expectedData = try? encoder.encode(event)

        let jsonBodyParameter = HTTPJSONBodyParameter(encodable: event, encoder: encoder)

        // Act
        let data = jsonBodyParameter.data

        // Assert
        XCTAssertEqual(expectedData, data)
    }
}
