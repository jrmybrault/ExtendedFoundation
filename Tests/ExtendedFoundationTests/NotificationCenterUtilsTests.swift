//
//  NotificationCenterUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class NotificationCenterUtilsTests: XCTestCase {

    struct MessagePayload: Equatable {

        enum Constants {
            static let notificationName = Notification.Name("NewMessageNotification")

            fileprivate static let userInfoAuthorKey = "author"
            fileprivate static let userInfoTextKey = "text"
        }

        // MARK: - Properties

        let author: String
        let text: String

        // MARK: - Init

        init(author: String, text: String) {
            self.author = author
            self.text = text
        }

        init(notification: Notification) {
            guard notification.name == Constants.notificationName,
                let userInfo = notification.userInfo,
                let author = userInfo[Constants.userInfoAuthorKey] as? String,
                let text = userInfo[Constants.userInfoTextKey] as? String else {
                    fatalError("Could not init from notification \(notification)")
            }

            self.init(author: author, text: text)
        }

        // MARK: - Funcs

        func asNotification() -> Notification {
            return Notification(name: Constants.notificationName,
                                object: nil,
                                userInfo: [Constants.userInfoAuthorKey: author,
                                           Constants.userInfoTextKey: text])
        }
    }

    // MARK: - SUT

    private var notificationCenter: NotificationCenter!

    // MARK: - Funcs

    override func setUp() {
        super.setUp()

        notificationCenter = NotificationCenter.default
    }

    func testNotifyPayloadToObserverWhenSendingNotification() {
        // Arrange
        let notificationName = Notification.Name("NewMessageNotification")
        let notificationDescriptor = NotificationDescriptor<MessagePayload>(name: notificationName, convert: MessagePayload.init)

        let receptionExpectation = XCTestExpectation()
        var receivedNewMessage: MessagePayload?

        // Here we must declare `observingToken` even though we do not use it afterwards. If we don't, the token will
        // be immediately deallocated thus removing the observer.
        let observingToken = notificationCenter.addObserver(for: notificationDescriptor, onNotify: {
            receivedNewMessage = $0
            receptionExpectation.fulfill()
        })

        let newMessage = MessagePayload(author: "test author", text: "test text")

        // Act
        notificationCenter.post(newMessage.asNotification())

        // Assert
        wait(for: [receptionExpectation], timeout: TestConstants.defaultExpectationTimeout)

        XCTAssertEqual(newMessage, receivedNewMessage)
    }

    func testDoNotNotifyPayloadToCancelledObserverWhenSendingNotification() {
        // Arrange
        let notificationName = Notification.Name("NewMessageNotification")
        let notificationDescriptor = NotificationDescriptor<MessagePayload>(name: notificationName, convert: MessagePayload.init)

        let receptionExpectation = XCTestExpectation()
        receptionExpectation.isInverted = true
        var receivedNewMessage: MessagePayload?

        let observingToken = notificationCenter.addObserver(for: notificationDescriptor, onNotify: {
            receivedNewMessage = $0
            receptionExpectation.fulfill()
        })

        let newMessage = MessagePayload(author: "test author", text: "test text")

        DispatchQueue.global(qos: .background).async {
            self.notificationCenter.post(newMessage.asNotification())
        }

        // Act
        observingToken.cancel()
        
        // Assert
        wait(for: [receptionExpectation], timeout: TestConstants.defaultExpectationTimeout)

        XCTAssertNil(receivedNewMessage)
    }
}
