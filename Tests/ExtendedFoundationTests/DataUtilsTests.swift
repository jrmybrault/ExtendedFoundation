//
//  DataUtilsTests.swift
//  ExtendedFoundationTests
//
//  Created by JBR on 17/04/2020.
//  Copyright © 2020 Open. All rights reserved.
//

@testable import ExtendedFoundation
import Foundation
import XCTest

final class DataUtilsTests: XCTestCase {

    // MARK: - Func

    func testHexString() {
        // Arrange
        // swiftlint:disable line_length
        let latinString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vel lorem felis. Ut porttitor ipsum consequat feugiat aliquam. Duis lacinia elit quis diam vulputate varius. Integer ut feugiat lacus, eget rhoncus turpis. Maecenas nec iaculis lorem. Pellentesque nec lobortis turpis. Pellentesque vitae vestibulum dui."
        let latinStringData = latinString.data(using: .utf8)
        let latinExpectedHexString = "4C6F72656D20697073756D20646F6C6F722073697420616D65742C20636F6E73656374657475722061646970697363696E6720656C69742E20447569732076656C206C6F72656D2066656C69732E20557420706F72747469746F7220697073756D20636F6E736571756174206665756769617420616C697175616D2E2044756973206C6163696E696120656C69742071756973206469616D2076756C707574617465207661726975732E20496E74656765722075742066657567696174206C616375732C20656765742072686F6E637573207475727069732E204D616563656E6173206E656320696163756C6973206C6F72656D2E2050656C6C656E746573717565206E6563206C6F626F72746973207475727069732E2050656C6C656E74657371756520766974616520766573746962756C756D206475692E"

        let specialString = "WTSD/%?UV  vL:S(0w`KKmGj2XCD5 SO_fqJWNMsHUr0o*Ud *38l1_WG3F2(VO fZFZJ17(#''&)*YD'C*Ju- 8N`yQpU#fk% HfwmDM!91Vl4 !@rVZ'W?83e1e7? 6,`c5-CV/N*lL#6 7PlgrWoGk&?IXY/Y097K JsiE#3gXhYH9_zU#oP3K-Hq'.,-'ui58@ukXe&IF^@f d?tLpuc&Q^a_?'0V;YsYa;O!K5Vzj%oqVy x1sC'K&y7'R@L2U%`Qa?A 0Z#Cl5Dm8AhK3L^y^*(ocf5bqlM5RwU#ym .Mu7s PJxgINS3.K5l?Q0JAuikXks 1d1yp*La%036Vv,gG:SFvnlGe5S_/@Ae^w-_ Zryf-J77*wJqNDd)X xW?)8YPN8*qzaJ) ?3'8KCs56m:8rRD) 4N@A_7t*X&TcrsZ285:?,**Cu/Jk@8lf(q*@zdEId;C0GHdc--i;lJ`ayD,!"
        let specialStringData = specialString.data(using: .utf8)
        let specialExpectedHexString = "575453442F253F55562020764C3A53283077604B4B6D476A325843443520534F5F66714A574E4D73485572306F2A5564202A33386C315F574733463228564F20665A465A4A31372823272726292A594427432A4A752D20384E607951705523666B25204866776D444D213931566C3420214072565A27573F3833653165373F20362C6063352D43562F4E2A6C4C23362037506C6772576F476B263F4958592F593039374B204A73694523336758685948395F7A55236F50334B2D4871272E2C2D277569353840756B58652649465E406620643F744C70756326515E615F3F2730563B597359613B4F214B35567A6A256F7156792078317343274B2679372752404C3255256051613F4120305A23436C35446D3841684B334C5E795E2A286F63663562716C4D3552775523796D202E4D75377320504A7867494E53332E4B356C3F51304A4175696B586B732031643179702A4C612530333656762C67473A5346766E6C476535535F2F4041655E772D5F205A7279662D4A37372A774A714E446429582078573F293859504E382A717A614A29203F3327384B437335366D3A387252442920344E40415F37742A5826546372735A3238353A3F2C2A2A43752F4A6B40386C6628712A407A644549643B4330474864632D2D693B6C4A606179442C21"
        // swiftlint:enable line_length

        // Assert
        XCTAssertEqual(latinExpectedHexString, latinStringData?.hexEncodedString(options: .upperCase))
        XCTAssertEqual(specialExpectedHexString, specialStringData?.hexEncodedString(options: .upperCase))
    }

    func testAppendStringIsEqualsToFullString() {
        // Arrange
        let stringPart1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis vel lorem felis. "
        let stringPart2 = "Ut porttitor ipsum consequat feugiat aliquam. Duis lacinia elit quis diam vulputate varius. "
        let stringPart3 = "Integer ut feugiat lacus, eget rhoncus turpis. Maecenas nec iaculis lorem."
        let stringPart4 = "Pellentesque nec lobortis turpis. Pellentesque vitae vestibulum dui."
        let fullString = stringPart1 + stringPart2 + stringPart3 + stringPart4

        let encoding: String.Encoding = .utf8
        let fullStringData = fullString.data(using: encoding)

        var comparedData = Data()

        // Act
        comparedData.append(stringPart1, encoding: encoding)
        comparedData.append(stringPart2, encoding: encoding)
        comparedData.append(stringPart3, encoding: encoding)
        comparedData.append(stringPart4, encoding: encoding)
        
        // Assert
        XCTAssertEqual(fullStringData, comparedData)
    }
}
