//
//  HTTPStatusCode.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 20/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public enum HTTPStatusCode: UInt {

    case `continue` = 100
    case switchingProtocols = 101
    case processing = 102
    case earlyHints = 103

    // swiftlint:disable identifier_name
    case ok = 200
    // swiftlint:enable identifier_name
    case created = 201
    case accepted = 202
    case nonAuthoritativeInformation = 203
    case noContent = 204
    case resetContent = 205
    case partialContent = 206
    case multiStatus = 207
    case alreadyReported = 208
    case contentDifferent = 210
    case imUsed = 226

    case multipleChoices = 300
    case movePermanently = 301
    case found = 302
    case seeOther = 303
    case notModified = 304
    case useProxy = 305
    case switchProxy = 306
    case temporaryRedirect = 307
    case permenentRedirect = 308
    case tooManyRedirects = 310

    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeOut = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case requestEntityTooLarge = 413
    case requestUriTooLong = 414
    case unsupportedMediaType = 415
    case requestedRangeUnsatisfiable = 416
    case expectationFailed = 417
    case iAmATeapot = 418
    case badMapping = 421
    case unprocessableEntity = 422
    case locked = 423
    case methodFailure = 424
    case unorderedCollection = 425
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequests = 429
    case requestHeaderFieldsTooLarge = 431
    case noResponse = 444
    case retryWith = 449
    case blockedByWindowsParentalControls = 450
    case unavailableForLegalReasons = 451
    case unrecoverableError = 456
    case sslCertificateError = 495
    case sslCertificateRequired = 496
    case httpRequestSentToHttpsPort = 497
    case tokenExpiredOrInvalid = 498
    case clientClosedRequest = 499

    case internalServerError = 500
    case notImplemented = 501
    case badGatewayOrProxyError = 502
    case serviceUnavailable = 503
    case gatewayTimeOut = 504
    case httpVersionNotSupported = 505
    case variantAlsoNegotiates = 506
    case insufficientStorage = 507
    case loopDetected = 508
    case bandwithLimitExceeded = 509
    case notExtented = 510
    case networkAuthenticationRequired = 511
    case unknownError = 520
    case webServerIsDown = 521
    case connectionTimedOut = 522
    case originIsUnreachable = 523
    case timeoutOccured = 524
    case sslHandshakeFailed = 525
    case invalidSslCertificate = 526
    case railgunError = 527

    // MARK: - Constants

    private static let informationStatusRange: Range<UInt> = 100 ..< successStatusRange.lowerBound
    private static let successStatusRange: Range<UInt> = 200 ..< redirectionStatusRange.lowerBound
    private static let redirectionStatusRange: Range<UInt> = 300 ..< clientErrorStatusRange.lowerBound
    private static let clientErrorStatusRange: Range<UInt> = 400 ..< serverErrorStatusRange.lowerBound
    private static let serverErrorStatusRange: Range<UInt> = 500 ..< 600

    // MARK: - Funcs

    public var value: UInt {
        return rawValue
    }

    public var isInformation: Bool {
        return HTTPStatusCode.informationStatusRange.contains(rawValue)
    }

    public var isSuccess: Bool {
        return HTTPStatusCode.successStatusRange.contains(rawValue)
    }

    public var isRedirection: Bool {
        return HTTPStatusCode.redirectionStatusRange.contains(rawValue)
    }

    public var isClientError: Bool {
        return HTTPStatusCode.clientErrorStatusRange.contains(rawValue)
    }

    public var isServerError: Bool {
        return HTTPStatusCode.serverErrorStatusRange.contains(rawValue)
    }
}
