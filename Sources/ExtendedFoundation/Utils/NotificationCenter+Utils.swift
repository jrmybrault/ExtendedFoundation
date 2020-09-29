//
//  NotificationCenter+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 30/01/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public final class NotificationCenterToken {

    // MARK: - Properties

    private let token: NSObjectProtocol
    private unowned let notificationCenter: NotificationCenter

    // MARK: - Init

    init(token: NSObjectProtocol, notificationCenter: NotificationCenter) {
        self.token = token
        self.notificationCenter = notificationCenter
    }

    deinit {
        cancel()
    }

    // MARK: - Funcs

    func cancel() {
        notificationCenter.removeObserver(token)
    }
}

public struct NotificationDescriptor<Payload> {

    // MARK: - Properties

    public let name: Notification.Name
    let convert: Mapper<Notification, Payload>

    // MARK: - Init

    public init(name: Notification.Name, convert: @escaping Mapper<Notification, Payload>) {
        self.name = name
        self.convert = convert
    }
}

extension NotificationCenter {

    public func addObserver<Payload>(for descriptor: NotificationDescriptor<Payload>,
                                     object: Any? = nil,
                                     queue: OperationQueue? = nil,
                                     onNotify block: @escaping Consumer<Payload>) -> NotificationCenterToken {
        let observerToken = addObserver(forName: descriptor.name, object: object, queue: queue) { notification in
            block(descriptor.convert(notification))
        }

        return NotificationCenterToken(token: observerToken, notificationCenter: self)
    }
}
