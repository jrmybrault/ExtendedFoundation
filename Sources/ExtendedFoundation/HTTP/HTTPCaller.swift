//
//  HTTPCaller.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 16/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public final class HTTPCaller {

    // MARK: - Properties

    private let requestLauncher: HTTPRequestLauncher

    private let jsonDecoder: JSONDecoder

    private var requestInterceptors = [HTTPRequestInterceptor]()
    private var resultInterceptors = [HTTPResultInterceptor]()

    public private(set) var isActive = false {
        didSet {
            if isActive != oldValue {
                onIsActiveStateChange?(isActive)
            }
        }
    }
    var onIsActiveStateChange: Consumer<Bool>?

    // MARK: - Init

    public init(requestLauncher: HTTPRequestLauncher, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.requestLauncher = requestLauncher
        self.jsonDecoder = jsonDecoder
    }

    // MARK: - Funcs

    /// Launch the provided request.
    /// - Parameters:
    ///   - request: The request to launch.
    ///   - shouldPrepareRequest: Whether the provided request should pass through the interceptors chain or not.
    ///   - shouldConveyResult: Whether the result should pass through through the interceptors chain or not.
    ///   - onResult: The closure to call when the request is complete.
    public func call(request: HTTPRequest,
                     shouldPrepareRequest: Bool = true,
                     shouldConveyResult: Bool = true,
                     onResult: @escaping Consumer<HTTPCallResult>) -> CancellableTask {
        isActive = true

        let definitiveRequest = shouldPrepareRequest ? prepareRequest(request) : request

        return requestLauncher.launch(definitiveRequest) { [weak self] result in
            guard let strongSelf = self else { return }

            if shouldConveyResult {
                strongSelf.conveyResult(result, for: request)
            }
            onResult(result)

            strongSelf.isActive = false
        }
    }

    /// Launch the provided request.
    /// - Parameters:
    ///   - request: The request to launch.
    ///   - shouldPrepareRequest: Whether the provided request should pass through the interceptors chain or not.
    ///   - decodingType: The type of  data expected to be decoded.
    ///   - shouldConveyResult: Whether the result should pass through through the interceptors chain or not.
    ///   - onResult: The closure to call when the request is complete.
    public func call<Value>(request: HTTPRequest,
                            shouldPrepareRequest: Bool = true,
                            decodingType: Value.Type,
                            shouldConveyResult: Bool = true,
                            onResult: @escaping Consumer<HTTPCallDecodedResult<Value>>) -> CancellableTask where Value: Decodable {
        return call(request: request, shouldPrepareRequest: shouldPrepareRequest, shouldConveyResult: shouldConveyResult) { [weak self] result in
            guard let strongSelf = self else { return }

            let mappedResult = result
                .flatMap({ response -> HTTPCallDecodedResult<Value> in
                    guard let data = response.data else {
                        return .failure(HTTPUnexpectedEmptyDataError())
                    }

                    do {
                        let decodedValue = try strongSelf.jsonDecoder.decode(decodingType, from: data)

                        return .success(HTTPCallDecodedResponse(httpResponse: response.httpResponse, value: decodedValue))
                    } catch {
                        return .failure(HTTPDataDecodingError(data: data, rootError: error))
                    }
                })
                .flatMapError({ error -> HTTPCallDecodedResult<Value> in
                    .failure(error)
                })

            onResult(mappedResult)
        }
    }

    private func prepareRequest(_ request: HTTPRequest) -> HTTPRequest {
        return requestInterceptors
            .sorted(by: \.priority)
            .reduce(request, { request, interceptor in
                interceptor.intercept(request)
            })
    }

    private func conveyResult(_ result: HTTPCallResult, for request: HTTPRequest) {
        return resultInterceptors
            .filter({ $0.shouldIntercept(request) })
            .sorted(by: \.priority)
            .forEach({ $0.intercept(result, for: request) })
    }
}

extension HTTPCaller {

    public func addRequestInterceptor(_ interceptor: HTTPRequestInterceptor) {
        requestInterceptors.append(interceptor)
    }

    public func removeRequestInterceptor(_ interceptor: HTTPRequestInterceptor) {
        if let interceptorIndex = requestInterceptors.firstIndex(where: { $0 === interceptor }) {
            requestInterceptors.remove(at: interceptorIndex)
        }
    }

    public func addResultInterceptor(_ interceptor: HTTPResultInterceptor) {
        resultInterceptors.append(interceptor)
    }
    
    public func removeResultInterceptor(_ interceptor: HTTPResultInterceptor) {
        if let interceptorIndex = resultInterceptors.firstIndex(where: { $0 === interceptor }) {
            resultInterceptors.remove(at: interceptorIndex)
        }
    }
}
