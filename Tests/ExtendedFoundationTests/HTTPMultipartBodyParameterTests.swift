//
//  HTTPMultipartBodyParameterTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class HTTPMultipartBodyParameterTests: XCTestCase {

    // MARK: - Funcs

    // swiftlint:disable function_body_length
    func testReturnsProperDataAndMimeTypeForUploadableJSONContent() {
        // Arrange
        let json = """
            [{
                "id": "d3a066d246f7ab88ab484e2687141d0ada2d49269276c93db150188ee49e6f74",
                "first_name": "Reagan",
                "last_name": "Docharty",
                "email": null,
                "gender": "Male",
                "job": "Human Resources Manager"
            }, {
                "id": "b3316471545b4cdf9a618372bacf73a4d758b6840581efbd4c065b71020d28d6",
                "first_name": "Dedie",
                "last_name": "Rittmeyer",
                "email": null,
                "gender": "Female",
                "job": "Administrative Officer"
            }, {
                "id": "a5eb69fc156c5e11811e50434ae13f45aaebd7ab1b1bc09f9fe278b1a3168d1a",
                "first_name": "Maurine",
                "last_name": "Rubinowitsch",
                "email": "mrubinowitsch2@jigsy.com",
                "gender": "Female",
                "job": "VP Accounting"
            }, {
                "id": "2fc5fec5c2333a12fcb077fdd701230a251d24798cc256683e0c0ca5fef34c0d",
                "first_name": "Reamonn",
                "last_name": "Akister",
                "email": "rakister3@vistaprint.com",
                "gender": "Male",
                "job": "Human Resources Manager"
            }, {
                "id": "a42c03c49160af08fd283a988f5580106313825b19f108fefe578e595a24fba3",
                "first_name": "Livvyy",
                "last_name": "Larcombe",
                "email": null,
                "gender": "Female",
                "job": "General Manager"
            }]
         """

        let jsonData = json.data(using: .utf8) ?? Data()

        let uploadableMedia = UploadableMedia(key: "persons", fileName: "persons.json", data: jsonData, mimeType: MimeType(.json))
        let parameters = [("jsonParameter1Name", "jsonParameter1Value"),
                          ("jsonParameter2Name", "jsonParameter2Value")]

        let boundary = "jsontestboundary"

        // swiftlint:disable line_length
        let expectedBase64Content = "LS1qc29udGVzdGJvdW5kYXJ5DQpDb250ZW50LURpc3Bvc2l0aW9uOiBmb3JtLWRhdGE7IG5hbWU9Impzb25QYXJhbWV0ZXIxTmFtZSINCkNvbnRlbnQtTGVuZ3RoIDE5DQoNCmpzb25QYXJhbWV0ZXIxVmFsdWUNCi0tanNvbnRlc3Rib3VuZGFyeQ0KQ29udGVudC1EaXNwb3NpdGlvbjogZm9ybS1kYXRhOyBuYW1lPSJqc29uUGFyYW1ldGVyMk5hbWUiDQpDb250ZW50LUxlbmd0aCAxOQ0KDQpqc29uUGFyYW1ldGVyMlZhbHVlDQotLWpzb250ZXN0Ym91bmRhcnkNCkNvbnRlbnQtRGlzcG9zaXRpb246IGZvcm0tZGF0YTsgbmFtZT0icGVyc29ucyI7IGZpbGVuYW1lPSJwZXJzb25zLmpzb24iDQpDb250ZW50LVR5cGUgYXBwbGljYXRpb24vanNvbg0KQ29udGVudC1MZW5ndGggMTIzNA0KDQogICBbewogICAgICAgImlkIjogImQzYTA2NmQyNDZmN2FiODhhYjQ4NGUyNjg3MTQxZDBhZGEyZDQ5MjY5Mjc2YzkzZGIxNTAxODhlZTQ5ZTZmNzQiLAogICAgICAgImZpcnN0X25hbWUiOiAiUmVhZ2FuIiwKICAgICAgICJsYXN0X25hbWUiOiAiRG9jaGFydHkiLAogICAgICAgImVtYWlsIjogbnVsbCwKICAgICAgICJnZW5kZXIiOiAiTWFsZSIsCiAgICAgICAiam9iIjogIkh1bWFuIFJlc291cmNlcyBNYW5hZ2VyIgogICB9LCB7CiAgICAgICAiaWQiOiAiYjMzMTY0NzE1NDViNGNkZjlhNjE4MzcyYmFjZjczYTRkNzU4YjY4NDA1ODFlZmJkNGMwNjViNzEwMjBkMjhkNiIsCiAgICAgICAiZmlyc3RfbmFtZSI6ICJEZWRpZSIsCiAgICAgICAibGFzdF9uYW1lIjogIlJpdHRtZXllciIsCiAgICAgICAiZW1haWwiOiBudWxsLAogICAgICAgImdlbmRlciI6ICJGZW1hbGUiLAogICAgICAgImpvYiI6ICJBZG1pbmlzdHJhdGl2ZSBPZmZpY2VyIgogICB9LCB7CiAgICAgICAiaWQiOiAiYTVlYjY5ZmMxNTZjNWUxMTgxMWU1MDQzNGFlMTNmNDVhYWViZDdhYjFiMWJjMDlmOWZlMjc4YjFhMzE2OGQxYSIsCiAgICAgICAiZmlyc3RfbmFtZSI6ICJNYXVyaW5lIiwKICAgICAgICJsYXN0X25hbWUiOiAiUnViaW5vd2l0c2NoIiwKICAgICAgICJlbWFpbCI6ICJtcnViaW5vd2l0c2NoMkBqaWdzeS5jb20iLAogICAgICAgImdlbmRlciI6ICJGZW1hbGUiLAogICAgICAgImpvYiI6ICJWUCBBY2NvdW50aW5nIgogICB9LCB7CiAgICAgICAiaWQiOiAiMmZjNWZlYzVjMjMzM2ExMmZjYjA3N2ZkZDcwMTIzMGEyNTFkMjQ3OThjYzI1NjY4M2UwYzBjYTVmZWYzNGMwZCIsCiAgICAgICAiZmlyc3RfbmFtZSI6ICJSZWFtb25uIiwKICAgICAgICJsYXN0X25hbWUiOiAiQWtpc3RlciIsCiAgICAgICAiZW1haWwiOiAicmFraXN0ZXIzQHZpc3RhcHJpbnQuY29tIiwKICAgICAgICJnZW5kZXIiOiAiTWFsZSIsCiAgICAgICAiam9iIjogIkh1bWFuIFJlc291cmNlcyBNYW5hZ2VyIgogICB9LCB7CiAgICAgICAiaWQiOiAiYTQyYzAzYzQ5MTYwYWYwOGZkMjgzYTk4OGY1NTgwMTA2MzEzODI1YjE5ZjEwOGZlZmU1NzhlNTk1YTI0ZmJhMyIsCiAgICAgICAiZmlyc3RfbmFtZSI6ICJMaXZ2eXkiLAogICAgICAgImxhc3RfbmFtZSI6ICJMYXJjb21iZSIsCiAgICAgICAiZW1haWwiOiBudWxsLAogICAgICAgImdlbmRlciI6ICJGZW1hbGUiLAogICAgICAgImpvYiI6ICJHZW5lcmFsIE1hbmFnZXIiCiAgIH1dDQoNCi0tanNvbnRlc3Rib3VuZGFyeS0tDQo="
        // swiftlint:enable line_length

        // Act
        let multipartBodyParameter = HTTPMultipartBodyParameter(media: uploadableMedia, parameters: parameters, boundary: boundary)

        // Assert
        XCTAssertEqual(expectedBase64Content, multipartBodyParameter.data?.base64EncodedString())
        XCTAssertEqual(MimeType(.multipartFormData, parameter: ("boundary", boundary)), multipartBodyParameter.mimeType)
    }
    // swiftlint:enalbe function_body_length

    func testReturnsProperDataAndMimeTypeForUploadablePNGContent() {
        // Arrange
        let image = UIImage(named: "fakeImage")
        let imageData = image?.pngData() ?? Data()

        let uploadableMedia = UploadableMedia(key: "photo", fileName: "image.png", data: imageData, mimeType: MimeType(.pngImage))
        let parameters = [("imageParameterName", "imageParameterValue")]

        let boundary = "imagetestboundary"

        // swiftlint:disable line_length
        let expectedBase64Content = "LS1pbWFnZXRlc3Rib3VuZGFyeQ0KQ29udGVudC1EaXNwb3NpdGlvbjogZm9ybS1kYXRhOyBuYW1lPSJpbWFnZVBhcmFtZXRlck5hbWUiDQpDb250ZW50LUxlbmd0aCAxOQ0KDQppbWFnZVBhcmFtZXRlclZhbHVlDQotLWltYWdldGVzdGJvdW5kYXJ5DQpDb250ZW50LURpc3Bvc2l0aW9uOiBmb3JtLWRhdGE7IG5hbWU9InBob3RvIjsgZmlsZW5hbWU9ImltYWdlLnBuZyINCkNvbnRlbnQtVHlwZSBpbWFnZS9wbmcNCkNvbnRlbnQtTGVuZ3RoIDANCg0KDQoNCi0taW1hZ2V0ZXN0Ym91bmRhcnktLQ0K"
        // swiftlint:enable line_length

        // Act
        let multipartBodyParameter = HTTPMultipartBodyParameter(media: uploadableMedia, parameters: parameters, boundary: boundary)

        // Assert
        XCTAssertEqual(expectedBase64Content, multipartBodyParameter.data?.base64EncodedString())
        XCTAssertEqual(MimeType(.multipartFormData, parameter: ("boundary", boundary)), multipartBodyParameter.mimeType)
    }
}
