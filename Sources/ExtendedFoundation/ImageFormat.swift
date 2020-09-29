//
//  ImageFormat.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 17/04/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public enum ImageFormat {

    case jpeg(compressionQuality: Percentage)
    case png

    // MARK: - Funcs

    public var `extension`: String {
        switch self {
        case .jpeg: return "jpeg"
        case .png: return "png"
        }
    }

    public var mimeType: MimeType {
        switch self {
        case .jpeg: return MimeType(.jpegImage)
        case .png: return MimeType(.pngImage)
        }
    }
}
