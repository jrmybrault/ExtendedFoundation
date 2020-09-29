//
//  HTTPRequestTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class HTTPRequestTests: XCTestCase {

    // MARK: - Funcs

    func testInitSuccessWhenUsingValidURL() {
        // Arrange
        var components = URLComponents()
        components.scheme = "http"
        components.host = "test.hostname.com"
        components.port = 23
        components.path = "/testapi/v1/testresource/10"
        let firstQueryItem = URLQueryItem(name: "firstItemName", value: "firstItemValue")
        let secondQueryItem = URLQueryItem(name: "secondItemName", value: "secondItemValue")
        components.queryItems = [firstQueryItem, secondQueryItem]

        // swiftlint:disable force_unwrapping
        let url = components.url!
        // swiftlint:enable force_unwrapping

        // Act
        let request = HTTPRequest(url: url, identifier: "test identifier")

        // Assert
        XCTAssertNotNil(request)
        XCTAssertEqual(components.scheme, request?.api.scheme.rawValue)
        XCTAssertEqual(components.host, request?.api.host)
        XCTAssertEqual(components.port, request?.api.port)
        XCTAssertEqual(components.path, request?.api.path)
        XCTAssertFalse(request?.isUpload ?? true)
        XCTAssertEqual(firstQueryItem.value, request?.queryParameters[firstQueryItem.name])
        XCTAssertEqual(secondQueryItem.value, request?.queryParameters[secondQueryItem.name])
    }

    func testInitFailsWhenUsingInvalidURL() {
        // Arrange
        var components = URLComponents()
        components.scheme = "http"
        components.port = 23
        components.path = "/testapi/v1/testresource/10"
        let firstQueryItem = URLQueryItem(name: "firstItemName", value: "firstItemValue")
        let secondQueryItem = URLQueryItem(name: "secondItemName", value: "secondItemValue")
        components.queryItems = [firstQueryItem, secondQueryItem]

        // swiftlint:disable force_unwrapping
        let url = components.url!
        // swiftlint:enable force_unwrapping

        // Act
        let request = HTTPRequest(url: url, identifier: "test identifier")

        // Assert
        XCTAssertNil(request)
    }

    func testInitWithAdditionalQueryParametersAndHeaders() {
        // Arrange
        let baseRequest = HTTPRequest(api: HTTPAPI(scheme: .https, host: "hostname.com"),
                                      identifier: "identifier",
                                      path: "/path",
                                      method: .get,
                                      queryParameters: ["firstParameterName": "firstParameterValue"],
                                      headers: [.userAgent("userAgent")])

        let additionalQueryParameters = ["firstAdditionalParameterName": "firstAdditionalParameterValue",
                                         "secondAdditionalParameterName": "secondAdditionalParameterValue"]
        let additionalHeaders: [HTTPHeader] = [.acceptEncoding("utf-8"),
                                               .contentType(MimeType(.textHtml))]

        let expectedQueryParameters = baseRequest.queryParameters.merging(additionalQueryParameters, uniquingKeysWith: { current, _ in current })
        let expectedHeaders = baseRequest.headers + additionalHeaders

        // Act
        let enrichedRequest = HTTPRequest(request: baseRequest,
                                          additionalQueryParameters: additionalQueryParameters,
                                          additionalHeaders: additionalHeaders)

        // Assert
        XCTAssertEqual(HTTPRequest(api: baseRequest.api,
                                   identifier: baseRequest.identifier,
                                   path: baseRequest.path,
                                   method: baseRequest.method,
                                   isUpload: baseRequest.isUpload,
                                   queryParameters: expectedQueryParameters,
                                   bodyParameter: baseRequest.bodyParameter,
                                   headers: expectedHeaders),
                       enrichedRequest)
    }

    // swiftlint:disable function_body_length
    func testIsEqualOnlyWhenAllSubpartsMatch() {
        // Arrange
        // swiftlint:disable force_unwrapping
        let referenceRequest = HTTPRequest(api: HTTPAPI(scheme: .https, host: "reference.hostname.com"),
                                           identifier: "reference identifier",
                                           path: "/referencePath",
                                           method: .post,
                                           isUpload: true,
                                           queryParameters: ["referenceQueryParameterName": "referenceQueryParameterValue"],
                                           bodyParameter: HTTPRawBodyParameter(data: "rawReferenceData".data(using: .utf8)!),
                                           headers: [.userAgent("referenceUserAgent")])
        // swiftlint:enable force_unwrapping

        // Assert
        XCTAssertNotEqual(referenceRequest, HTTPRequest(api: HTTPAPI(scheme: .http, host: referenceRequest.api.host),
                                                        identifier: referenceRequest.identifier,
                                                        path: referenceRequest.path,
                                                        method: referenceRequest.method,
                                                        isUpload: referenceRequest.isUpload,
                                                        queryParameters: referenceRequest.queryParameters,
                                                        bodyParameter: referenceRequest.bodyParameter,
                                                        headers: referenceRequest.headers))
        XCTAssertNotEqual(referenceRequest, HTTPRequest(api: referenceRequest.api,
                                                        identifier: "test identifier",
                                                        path: referenceRequest.path,
                                                        method: referenceRequest.method,
                                                        isUpload: referenceRequest.isUpload,
                                                        queryParameters: referenceRequest.queryParameters,
                                                        bodyParameter: referenceRequest.bodyParameter,
                                                        headers: referenceRequest.headers))
        XCTAssertNotEqual(referenceRequest, HTTPRequest(api: referenceRequest.api,
                                                        identifier: referenceRequest.identifier,
                                                        path: "/testpath",
                                                        method: referenceRequest.method,
                                                        isUpload: referenceRequest.isUpload,
                                                        queryParameters: referenceRequest.queryParameters,
                                                        bodyParameter: referenceRequest.bodyParameter,
                                                        headers: referenceRequest.headers))
        XCTAssertNotEqual(referenceRequest, HTTPRequest(api: referenceRequest.api,
                                                        identifier: referenceRequest.identifier,
                                                        path: referenceRequest.path,
                                                        method: .get,
                                                        isUpload: referenceRequest.isUpload,
                                                        queryParameters: referenceRequest.queryParameters,
                                                        bodyParameter: referenceRequest.bodyParameter,
                                                        headers: referenceRequest.headers))
        XCTAssertNotEqual(referenceRequest, HTTPRequest(api: referenceRequest.api,
                                                        identifier: referenceRequest.identifier,
                                                        path: referenceRequest.path,
                                                        method: referenceRequest.method,
                                                        isUpload: !referenceRequest.isUpload,
                                                        queryParameters: referenceRequest.queryParameters,
                                                        bodyParameter: referenceRequest.bodyParameter,
                                                        headers: referenceRequest.headers))
        XCTAssertNotEqual(referenceRequest, HTTPRequest(api: referenceRequest.api,
                                                        identifier: referenceRequest.identifier,
                                                        path: referenceRequest.path,
                                                        method: referenceRequest.method,
                                                        isUpload: referenceRequest.isUpload,
                                                        queryParameters: [:],
                                                        bodyParameter: referenceRequest.bodyParameter,
                                                        headers: referenceRequest.headers))
        XCTAssertNotEqual(referenceRequest, HTTPRequest(api: referenceRequest.api,
                                                        identifier: referenceRequest.identifier,
                                                        path: referenceRequest.path,
                                                        method: referenceRequest.method,
                                                        isUpload: referenceRequest.isUpload,
                                                        queryParameters: referenceRequest.queryParameters,
                                                        bodyParameter: HTTPRawBodyParameter(data: Data()),
                                                        headers: referenceRequest.headers))
        XCTAssertNotEqual(referenceRequest, HTTPRequest(api: referenceRequest.api,
                                                        identifier: referenceRequest.identifier,
                                                        path: referenceRequest.path,
                                                        method: referenceRequest.method,
                                                        isUpload: referenceRequest.isUpload,
                                                        queryParameters: referenceRequest.queryParameters,
                                                        bodyParameter: referenceRequest.bodyParameter,
                                                        headers: []))
        XCTAssertEqual(referenceRequest, HTTPRequest(api: referenceRequest.api,
                                                     identifier: referenceRequest.identifier,
                                                     path: referenceRequest.path,
                                                     method: referenceRequest.method,
                                                     isUpload: referenceRequest.isUpload,
                                                     queryParameters: referenceRequest.queryParameters,
                                                     bodyParameter: referenceRequest.bodyParameter,
                                                     headers: referenceRequest.headers))
    }
    // swiftlint:enable function_body_length

    func testConversionToURL() {
        // Arrange
        let queryParameters = [(name: "firstParameterName", value: "firstParameterValue"),
                               (name: "secondParameterName", value: "secondParameterValue")]

        let request = HTTPRequest(api: HTTPAPI(scheme: .https, host: "hostname.com", port: 73, path: "/api"),
                                  identifier: "identifier",
                                  path: "path",
                                  method: .post,
                                  queryParameters: Dictionary(uniqueKeysWithValues: queryParameters.map({ ($0.name, $0.value) })),
                                  bodyParameter: HTTPRawBodyParameter(data: Data()),
                                  headers: [.userAgent("userAgent")])

        // Act
        let url = request.url

        // Assert
        // swiftlint:disable force_unwrapping
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        // swiftlint:enable force_unwrapping

        XCTAssertEqual(components.scheme, request.api.scheme.rawValue)
        XCTAssertEqual(components.host, request.api.host)
        XCTAssertEqual(components.port, request.api.port)
        XCTAssertEqual(components.path, "\(request.api.path ?? "")/\(request.path ?? "")")
        XCTAssertEqual(components.queryItems?.count, request.queryParameters.count)
        XCTAssertEqual(components.queryItems?.first(where: { $0.name == queryParameters[0].name })?.value, queryParameters[0].value)
        XCTAssertEqual(components.queryItems?.first(where: { $0.name == queryParameters[1].name })?.value, queryParameters[1].value)
    }

    func testConversionToURLRequest() {
        // Arrange
        let bodyString = "test body string"
        // swiftlint:disable force_unwrapping
        let bodyData = bodyString.data(using: .utf8)!
        // swiftlint:enable force_unwrapping

        let queryParameters = [(name: "firstParameterName", value: "firstParameterValue"),
                               (name: "secondParameterName", value: "secondParameterValue")]

        let userAgent = "test userAgent"

        let request = HTTPRequest(api: HTTPAPI(scheme: .https, host: "hostname.com", port: 73, path: "/api"),
                                  identifier: "identifier",
                                  path: "path",
                                  method: .post,
                                  queryParameters: ["firstParameterName": "firstParameterValue",
                                                    "secondParameterName": "secondParameterValue"],
                                  bodyParameter: HTTPRawBodyParameter(data: bodyData),
                                  headers: [.userAgent(userAgent)])

        let expectedHeaders = ["User-Agent": userAgent,
                               "Content-Type": MimeType(.bytes).description,
                               "Content-Length": String(bodyData.count)]
        // Act
        let urlRequest = request.urlRequest

        // Assert
        // swiftlint:disable force_unwrapping
        let url = request.urlRequest.url!
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        // swiftlint:enable force_unwrapping

        XCTAssertEqual(components.scheme, request.api.scheme.rawValue)
        XCTAssertEqual(components.host, request.api.host)
        XCTAssertEqual(components.port, request.api.port)
        XCTAssertEqual(components.path, "\(request.api.path ?? "")/\(request.path ?? "")")
        XCTAssertEqual(components.queryItems?.count, request.queryParameters.count)
        XCTAssertEqual(components.queryItems?.first(where: { $0.name == queryParameters[0].name })?.value, queryParameters[0].value)
        XCTAssertEqual(components.queryItems?.first(where: { $0.name == queryParameters[1].name })?.value, queryParameters[1].value)

        XCTAssertEqual(urlRequest.httpMethod?.uppercased(), request.method.rawValue.uppercased())
        XCTAssertEqual(urlRequest.allHTTPHeaderFields, expectedHeaders)
        XCTAssertEqual(urlRequest.httpBody, bodyData)
    }
}
