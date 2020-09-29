//
//  DebugPrintType.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 28/10/2019.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

public enum DebugPrintType {

    case `default`
    case info
    case warning
    case error(Error?)

    // MARK: - Funcs

    var prefix: String {
        switch self {
        case .default: return " 🔵 "
        case .info: return " ℹ️ "
        case .warning: return " ⚠️ "
        case .error: return " ❌ "
        }
    }

    var appendix: String {
        switch self {
        case let .error(error): return error.flatMap({ " \($0)" }) ?? ""
        default: return ""
        }
    }
}
