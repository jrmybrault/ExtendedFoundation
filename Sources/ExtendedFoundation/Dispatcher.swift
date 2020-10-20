//
//  Dispatcher.swift
//  
//
//  Created by Jérémy Brault on 20/10/2020.
//

import Foundation

public enum Dispatcher {

    // MARK: - Constants

    // Run all immediately in unit tests context to avoid the need of XCTestExpectation if possible
    private static let runAllImmediately: Bool = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil

    // MARK: - Funcs

    public static func sync(on queue: DispatchQueue, _ runnable: Runnable) {
        if runAllImmediately {
            Thread.isMainThread ? runnable() : DispatchQueue.main.sync(execute: runnable)
        } else {
            queue.sync(execute: runnable)
        }
    }

    public static func sync<T>(on queue: DispatchQueue, _ producer: Producer<T>) -> T {
        if runAllImmediately {
            return Thread.isMainThread ? producer() : DispatchQueue.main.sync(execute: producer)
        } else {
            return queue.sync(execute: producer)
        }
    }

    public static func async(on queue: DispatchQueue, _ runnable: @escaping Runnable) {
        if runAllImmediately {
            Thread.isMainThread ? runnable() : DispatchQueue.main.sync(execute: runnable)
        } else {
            queue.async(execute: runnable)
        }
    }
}
