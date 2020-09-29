//
//  DateUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class DateUtilsTests: XCTestCase {
    
    // MARK: - Funcs
    
    func testNowIsEqualToCurrentDate() {
        // Arrange
        let comparedComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second, .calendar, .timeZone]
        let currentDateComponents = Calendar.current.dateComponents(comparedComponents, from: Date())
        
        // Act
        let nowComponents = Calendar.current.dateComponents(comparedComponents, from: Date.now)
        
        // Assert
        XCTAssertEqual(currentDateComponents.year, nowComponents.year)
        XCTAssertEqual(currentDateComponents.month, nowComponents.month)
        XCTAssertEqual(currentDateComponents.day, nowComponents.day)
        XCTAssertEqual(currentDateComponents.hour, nowComponents.hour)
        XCTAssertEqual(currentDateComponents.minute, nowComponents.minute)
        XCTAssertEqual(currentDateComponents.second, nowComponents.second)
        XCTAssertEqual(currentDateComponents.calendar, nowComponents.calendar)
        XCTAssertEqual(currentDateComponents.timeZone, nowComponents.timeZone)
    }
    
    func testTodayIsEqualToCurrentDateDay() {
        // Arrange
        let comparedComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .calendar, .timeZone]
        let currentDateComponents = Calendar.current.dateComponents(comparedComponents, from: Date())
        
        // Act
        let nowComponents = Calendar.current.dateComponents(comparedComponents, from: Date.today)
        
        // Assert
        XCTAssertEqual(currentDateComponents.year, nowComponents.year)
        XCTAssertEqual(currentDateComponents.month, nowComponents.month)
        XCTAssertEqual(currentDateComponents.day, nowComponents.day)
        XCTAssertEqual(currentDateComponents.calendar, nowComponents.calendar)
        XCTAssertEqual(currentDateComponents.timeZone, nowComponents.timeZone)
    }
    
    func testDayBefore() {
        // Arrange
        let comparedComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second, .calendar, .timeZone]
        // swiftlint:disable force_unwrapping
        let date = Calendar.date(year: 2020, month: 04, day: 18)!
        // swiftlint:enable force_unwrapping
        let dateComponents = Calendar.current.dateComponents(comparedComponents, from: date)
        
        // Act
        let yesterdayComponents = Calendar.current.dateComponents(comparedComponents, from: date.dayBefore)
        
        // Assert
        XCTAssertEqual(dateComponents.year, yesterdayComponents.year)
        XCTAssertEqual(dateComponents.month, yesterdayComponents.month)
        // swiftlint:disable force_unwrapping
        XCTAssertEqual(dateComponents.day! - 1, yesterdayComponents.day)
        // swigtlint:enable force_unwrapping
        XCTAssertEqual(dateComponents.hour, yesterdayComponents.hour)
        XCTAssertEqual(dateComponents.minute, yesterdayComponents.minute)
        XCTAssertEqual(dateComponents.second, yesterdayComponents.second)
        XCTAssertEqual(dateComponents.calendar, yesterdayComponents.calendar)
        XCTAssertEqual(dateComponents.timeZone, yesterdayComponents.timeZone)
    }
    
    func testDayAfter() {
        // Arrange
        let comparedComponents: Set<Calendar.Component> = [.era, .year, .month, .day, .hour, .minute, .second, .calendar, .timeZone]
        // swiftlint:disable force_unwrapping
        let date = Calendar.date(year: 2020, month: 04, day: 18)!
        // swiftlint:enable force_unwrapping
        let dateComponents = Calendar.current.dateComponents(comparedComponents, from: date)
        
        // Act
        let tomorrowComponents = Calendar.current.dateComponents(comparedComponents, from: date.dayAfter)
        
        // Assert
        XCTAssertEqual(dateComponents.year, tomorrowComponents.year)
        XCTAssertEqual(dateComponents.month, tomorrowComponents.month)
        // swiftlint:disable force_unwrapping
        XCTAssertEqual(dateComponents.day! + 1, tomorrowComponents.day)
        // swigtlint:enable force_unwrapping
        XCTAssertEqual(dateComponents.hour, tomorrowComponents.hour)
        XCTAssertEqual(dateComponents.minute, tomorrowComponents.minute)
        XCTAssertEqual(dateComponents.second, tomorrowComponents.second)
        XCTAssertEqual(dateComponents.nanosecond, tomorrowComponents.nanosecond)
        XCTAssertEqual(dateComponents.calendar, tomorrowComponents.calendar)
        XCTAssertEqual(dateComponents.timeZone, tomorrowComponents.timeZone)
    }
    
    func testDateDayIsEqualToDayComponent() {
        // Arrange
        let date = Date()
        
        // Assert
        XCTAssertEqual(Calendar.current.dateComponents([.day], from: date).day, date.day.signed)
    }
    
    func testDateMonthIsEqualToMonthComponent() {
        // Arrange
        let date = Date()
        
        // Assert
        XCTAssertEqual(Calendar.current.dateComponents([.month], from: date).month, date.month.signed)
    }
    
    func testDateYearIsEqualToYearComponent() {
        // Arrange
        let date = Date()
        
        // Assert
        XCTAssertEqual(Calendar.current.dateComponents([.year], from: date).year, date.year.signed)
    }
    
    func testNumberOfYearsSinceSameDateReturnsZero() {
        // Arrange
        let date = Date()
        
        // Assert
        XCTAssertEqual(0, date.numberOfYearsSince(date))
    }
    
    func testNumberOfYearsSinceAnteriorDate() {
        // Arrange
        let referenceDateYear: UInt = 2020
        let referenceDate = Calendar.date(year: referenceDateYear, month: 3, day: 6)
        let comparedDateYear: UInt = 1987
        let comparedDate = Calendar.date(year: comparedDateYear, month: 3, day: 6)
        
        // Assert
        // swiftlint:disable force_unwrapping
        XCTAssertEqual(referenceDateYear - comparedDateYear, referenceDate!.numberOfYearsSince(comparedDate!))
        // swiftlint:enable force_unwrapping
    }
    
    func testNumberOfYearsSinceAnteriorDateWhenTheDayIsPosterior() {
        // Arrange
        let referenceDateYear: UInt = 2020
        let referenceDate = Calendar.date(year: referenceDateYear, month: 3, day: 6)
        let comparedDateYear: UInt = 1987
        let comparedDate = Calendar.date(year: comparedDateYear, month: 3, day: 7)
        
        // Assert
        // swiftlint:disable force_unwrapping
        XCTAssertEqual(referenceDateYear - comparedDateYear - 1, referenceDate!.numberOfYearsSince(comparedDate!))
        // swiftlint:enable force_unwrapping
    }
    
    func testReferenceDatePlusSomeTimeReturnsExpectedDate() {
        // Arrange
        let referenceDateYear: UInt = 1937
        let referenceDateMonth: UInt = 10
        let referenceDay: UInt = 22
        let referenceDate = Calendar.date(year: referenceDateYear, month: referenceDateMonth, day: referenceDay)
        
        let yearDelta = 65
        let monthDelta = -14
        let dayDelta = 6813
        
        // Act
        let modifiedData1 = referenceDate?.plus(dateComponent: .year, value: yearDelta)
        let modifiedData2 = modifiedData1?.plus(dateComponent: .month, value: monthDelta)
        let modifiedData3 = modifiedData2?.plus(dateComponent: .day, value: dayDelta)
        
        // Assert
        XCTAssertEqual(Calendar.date(year: 2002, month: 10, day: 22), modifiedData1)
        XCTAssertEqual(Calendar.date(year: 2001, month: 8, day: 22), modifiedData2)
        XCTAssertEqual(Calendar.date(year: 2020, month: 4, day: 17), modifiedData3)
    }
    
    func testIsBefore() {
        // Arrange
        let date = Date()
        let anteriorDate = date.plus(dateComponent: .day, value: -3467)
        let posteriorDate = date.plus(dateComponent: .day, value: 289)
        
        // Assert
        XCTAssertFalse(date.isBefore(date))
        XCTAssertTrue(anteriorDate.isBefore(date))
        XCTAssertFalse(posteriorDate.isBefore(date))
    }
    
    func testIsAfter() {
        // Arrange
        let date = Date()
        let anteriorDate = date.plus(dateComponent: .day, value: -3467)
        let posteriorDate = date.plus(dateComponent: .day, value: 289)
        
        // Assert
        XCTAssertFalse(date.isAfter(date))
        XCTAssertFalse(anteriorDate.isAfter(date))
        XCTAssertTrue(posteriorDate.isAfter(date))
    }
    
    func testIsWithinPredicate() {
        // Arrange
        // swiftlint:disable force_unwrapping
        let dateRange = Calendar.date(year: 1937, month: 10, day: 22)! ... Calendar.date(year: 2020, month: 4, day: 17)!
        
        let isWithinPredicate = Date.isWithin(dateRange, or: { FakeError() })
        
        // Assert
        XCTAssertEqual(FakeError(), isWithinPredicate(dateRange.lowerBound.plus(dateComponent: .day, value: -4938)) as? FakeError)
        XCTAssertEqual(FakeError(), isWithinPredicate(dateRange.lowerBound.plus(dateComponent: .day, value: -1)) as? FakeError)
        XCTAssertNil(isWithinPredicate(dateRange.lowerBound))
        XCTAssertNil(isWithinPredicate(Calendar.date(year: 1988, month: 7, day: 2)!))
        XCTAssertEqual(FakeError(), isWithinPredicate(dateRange.upperBound.plus(dateComponent: .day, value: 1)) as? FakeError)
        XCTAssertEqual(FakeError(), isWithinPredicate(dateRange.upperBound.plus(dateComponent: .day, value: 87)) as? FakeError)
        // swiftlint:enable force_unwrapping
    }
}
