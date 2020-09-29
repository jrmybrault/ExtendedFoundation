//
//  URLSessionRequestLauncher.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 15/05/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public final class URLSessionRequestLauncher: HTTPRequestLauncher {

    typealias URLSessionTaskResultHandler = (Data?, URLResponse?, Error?) -> Void

    // MARK: - Properties

    private let session: URLSession

    private let jsonEncoder: JSONEncoder

    // MARK: - Init

    public init(session: URLSession = URLSession.shared, jsonEncoder: JSONEncoder = JSONEncoder()) {
        self.session = session
        self.jsonEncoder = jsonEncoder
    }

    // MARK: - Funcs

    public func launch(_ request: HTTPRequest, onResult: @escaping Consumer<HTTPCallResult>) -> CancellableTask {
        let urlRequest = request.urlRequest

        let resultHandler: URLSessionTaskResultHandler = { [weak self] data, response, error in
            if let callResult = self?.callResult(from: data, response: response, error: error) {
                onResult(callResult)
            }
        }

        let task = request.isUpload
            ? session.uploadTask(with: urlRequest, from: urlRequest.httpBody ?? Data())
            : session.dataTask(with: urlRequest, completionHandler: resultHandler)

        task.resume()

        return task
    }

    private func callResult(from data: Data?, response: URLResponse?, error: Error?) -> HTTPCallResult {
        var callResult: HTTPCallResult? = nil

        let httpResponse = response as? HTTPURLResponse
        let urlError = error as? URLError

        if let urlError = urlError {
            if urlError.isCancellation {
                callResult = .failure(HTTPError.cancelled)
            } else if urlError.isNoInternetConnection {
                callResult = .failure(HTTPError.noInternetConnection)
            }
        } else if let httpResponse = httpResponse, httpResponse.statusCode().isSuccess {
            callResult = .success(HTTPCallResponse(httpResponse: httpResponse, data: data))
        }

        return callResult ?? .failure(HTTPError.other(httpResponse, urlError, data))
    }
}

extension URLSessionDataTask: CancellableTask {
    
    public var isCancelled: Bool {
        return state == .canceling
    }
}
