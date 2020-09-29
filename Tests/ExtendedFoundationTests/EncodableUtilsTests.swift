//
//  EncodableUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class EncodableUtilsTests: XCTestCase {

    fileprivate struct Person: Equatable, Encodable {

        enum CodingKeys: String, CodingKey {
            case name
            case age
            case height
            case birthDate
        }

        // MARK: - Properties

        let name: String
        let age: UInt
        let rawHeight: String?
        let rawBirthDate: String?

        // MARK: - Init

        init(name: String, age: UInt, rawHeight: String? = nil, rawBirthDate: String? = nil) {
            self.name = name
            self.age = age
            self.rawHeight = rawHeight
            self.rawBirthDate = rawBirthDate
        }

        // MARK: - Funcs

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(name, forKey: .name)

            if let rawHeight = rawHeight {
                guard let height = Float(rawHeight) else {
                    throw FakeError()
                }

                try container.encode(height, forKey: .height)
            }

            if let rawBirthDate = rawBirthDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                guard let birthDate = dateFormatter.date(from: rawBirthDate) else {
                    throw FakeError()
                }
                try container.encode(birthDate, forKey: .birthDate)
            }
        }
    }

    // MARK: - Funcs

    func testJSONDataReturnsDataWhenEncodingSucceeds() {
        // Assert
        XCTAssertNotNil("test".jsonData())
        XCTAssertNotNil(1.jsonData())
        XCTAssertNotNil(true.jsonData())
        XCTAssertNotNil(Date().jsonData())
        XCTAssertNotNil(Person(name: "test", age: 20).jsonData())
        XCTAssertNotNil([Person(name: "test1", age: 20), Person(name: "test2", age: 30)].jsonData())
        XCTAssertNotNil(["persons": [Person(name: "test1", age: 20), Person(name: "test2", age: 30)]].jsonData())
    }

    func testJSONDataReturnsNilWhenEncodingFails() {
        // Assert
        XCTAssertNotNil(Person(name: "test", age: 20, rawHeight: "173", rawBirthDate: "4/17/2020").jsonData())
        XCTAssertNil(Person(name: "test", age: 20, rawHeight: "height", rawBirthDate: "4/17/2020").jsonData())
        XCTAssertNil(Person(name: "test", age: 20, rawHeight: "173", rawBirthDate: "birthDate").jsonData())
    }
}
