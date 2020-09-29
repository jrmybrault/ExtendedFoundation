//
//  HTTPRequestInterceptorTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 20/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class HTTPRequestInterceptorTests: XCTestCase {
    
    // MARK: - Funcs
    
    func testPriorityIsMinimalByDefault() {
        // Arrange
        let interceptor = BaseRequestInterceptor()
        
        // Assert
        XCTAssertEqual(UInt.min, interceptor.priority)
    }
}

fileprivate final class BaseRequestInterceptor: HTTPRequestInterceptor {
    
    func intercept(_ request: HTTPRequest) -> HTTPRequest {
        return request
    }
}
