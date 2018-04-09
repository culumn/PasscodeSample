//
//  UnderlineTextButtonTests.swift
//  PasscodeSampleUIKitTests
//
//  Created by Matsuoka Yoshiteru on 2018/04/09.
//  Copyright © 2018年 culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSampleUIKit

class UnderlineTextButtonTests: XCTestCase {

    var underlineTextButton: UnderlineTextButton!
    
    override func setUp() {
        super.setUp()

        underlineTextButton = UnderlineTextButton()
    }
    
    override func tearDown() {
        underlineTextButton = nil
        super.tearDown()
    }
    
    func testSetTitle() {
        let testTitle = "TestTitle"
        let testState = UIControlState.disabled

        underlineTextButton.setTitle(testTitle, for: testState)
        let underlineStyle = NSUnderlineStyle(rawValue: underlineTextButton.titleLabel?.attributedText?.attribute(.underlineStyle, at: 0, effectiveRange: nil) as! Int)
        XCTAssertEqual(underlineTextButton.title(for: testState), testTitle)
        XCTAssertEqual(underlineStyle, .styleSingle)
    }

    func testSetTitleWithNilTitle() {
        let testState = UIControlState.disabled

        underlineTextButton.setTitle(nil, for: testState)
        XCTAssertNil(underlineTextButton.title(for: testState))
        XCTAssertNil(underlineTextButton.titleLabel?.attributedText)
    }

    func testUnderlineText() {
        let testTitle = "TestTitle"
        underlineTextButton.underlineText = testTitle

        let underlineStyle = NSUnderlineStyle(rawValue: underlineTextButton.titleLabel?.attributedText?.attribute(.underlineStyle, at: 0, effectiveRange: nil) as! Int)
        XCTAssertEqual(underlineTextButton.title(for: .normal), testTitle)
        XCTAssertEqual(underlineStyle, .styleSingle)
    }

    func testNilUnderlineText() {
        underlineTextButton.underlineText = nil

        XCTAssertNil(underlineTextButton.title(for: .normal))
        XCTAssertNil(underlineTextButton.titleLabel?.attributedText)
    }
}
