//
//  Calendar+Utils.swift
//  ExtendedFoundation
//
//  Created by Jérémy Brault on 16/03/2020.
//  Copyright © 2020 Open. All rights reserved.
//

import Foundation

extension Calendar {

    public static func date(year: UInt, month: UInt, day: UInt) -> Date? {
        return date(year: Int(year), month: Int(month), day: Int(day))
    }

    public static func date(year: Int, month: Int, day: Int) -> Date? {
        return Calendar.current.date(from: DateComponents(year: year, month: month, day: day))
    }
}
