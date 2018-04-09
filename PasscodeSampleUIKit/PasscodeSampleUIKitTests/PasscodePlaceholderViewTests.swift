//
//  PasscodePlaceholderViewTests.swift
//  PasscodeSampleUIKitTests
//
//  Created by Matsuoka Yoshiteru on 2018/04/09.
//  Copyright © 2018年 culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSampleUIKit

class PasscodePlaceholderViewTests: XCTestCase {

    var passcodePalceholderView: PasscodePlaceholderView!
    
    override func setUp() {
        super.setUp()

        passcodePalceholderView = PasscodePlaceholderView()
    }
    
    override func tearDown() {
        passcodePalceholderView = nil
        super.tearDown()
    }
    
    func testDraw() {
        let testRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        passcodePalceholderView.draw(testRect)

        XCTAssertTrue(passcodePalceholderView.layer.masksToBounds)
        XCTAssertEqual(passcodePalceholderView.layer.cornerRadius, min(testRect.width, testRect.height) / 2)
    }

    func testBorderColor() {
        let testColor = UIColor.white
        passcodePalceholderView.borderColor = testColor

        XCTAssertEqual(passcodePalceholderView.layer.borderColor, testColor.cgColor)
    }

    func testBorderWidth() {
        XCTAssert(passcodePalceholderView.borderWidth == 0)

        let testBorderWidth = CGFloat(10)
        passcodePalceholderView.borderWidth = testBorderWidth
        XCTAssertEqual(passcodePalceholderView.borderWidth, testBorderWidth)
    }

    func testFillColor() {
        let testColor = UIColor.white
        let expectation = self.expectation(description: "Animation async call")
        passcodePalceholderView.fillColor() { _ in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNotEqual(self.passcodePalceholderView.backgroundColor, testColor)
        }
    }

    func testFillColorWithFilledColor() {
        let testColor = UIColor.white
        let expectation = self.expectation(description: "Animation async call")
        passcodePalceholderView.filledColor = testColor
        passcodePalceholderView.fillColor() { _ in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertEqual(self.passcodePalceholderView.backgroundColor, testColor)
        }
    }

    func testFillEmpty() {
        let testColor = UIColor.white
        let expectation = self.expectation(description: "Animation async call")
        passcodePalceholderView.fillEmpty() { _ in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNotEqual(self.passcodePalceholderView.backgroundColor, testColor)
        }
    }

    func testFillEmptyWithEmptyColor() {
        let testColor = UIColor.white
        let expectation = self.expectation(description: "Animation async call")
        passcodePalceholderView.emptyColor = testColor
        passcodePalceholderView.fillEmpty() { _ in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertEqual(self.passcodePalceholderView.backgroundColor, testColor)
        }
    }

    func testFillErrorColor() {
        let testColor = UIColor.white
        let expectation = self.expectation(description: "Animation async call")
        passcodePalceholderView.fillErrorColor() { _ in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertNotEqual(self.passcodePalceholderView.backgroundColor, testColor)
        }
    }

    func testFillErrorColorWithErrorColor() {
        let testColor = UIColor.white
        let expectation = self.expectation(description: "Animation async call")
        passcodePalceholderView.errorColor = testColor
        passcodePalceholderView.fillErrorColor() { _ in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertEqual(self.passcodePalceholderView.backgroundColor, testColor)
        }
    }
}
