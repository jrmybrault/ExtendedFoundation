//
//  UploadableMedia.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 19/08/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public struct UploadableMedia: Equatable {

    // MARK: - Properties

    let key: String
    let fileName: String
    let data: Data
    let mimeType: MimeType

    // MARK: - Init

    public init?(key: String, fileName: String, data: Data, mimeType: MimeType) {
        self.key = key
        self.fileName = fileName
        self.data = data
        self.mimeType = mimeType
    }
}
