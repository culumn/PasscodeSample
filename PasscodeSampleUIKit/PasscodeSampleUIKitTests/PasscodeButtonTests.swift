//
//  PasscodeButtonTests.swift
//  PasscodeSampleUIKitTests
//
//  Created by Matsuoka Yoshiteru on 2018/04/09.
//  Copyright © 2018年 culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSampleUIKit

final class PasscodeButtonTests: XCTestCase {

    var passcodeButton: PasscodeButton!
    
    override func setUp() {
        super.setUp()

        passcodeButton = PasscodeButton()
    }
    
    override func tearDown() {
        passcodeButton = nil
        super.tearDown()
    }
    
    func testDraw() {
        let testRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        passcodeButton.draw(testRect)

        XCTAssertTrue(passcodeButton.layer.masksToBounds)
        XCTAssertEqual(passcodeButton.layer.cornerRadius, min(testRect.width, testRect.height) / 2)
    }

    func testBorderColor() {
        let testBorderColor = UIColor.black
        XCTAssert(passcodeButton.layer.borderColor != testBorderColor.cgColor)

        passcodeButton.borderColor = testBorderColor
        XCTAssertEqual(passcodeButton.layer.borderColor, testBorderColor.cgColor)
    }

    func testBorderWidth() {
        XCTAssert(passcodeButton.layer.borderWidth == 0)

        let testBorderWidth = CGFloat(10)
        passcodeButton.borderWidth = testBorderWidth
        XCTAssertEqual(passcodeButton.layer.borderWidth, testBorderWidth)
    }

    func testColor() {
        XCTAssert(passcodeButton.backgroundColor == nil)

        let testColor = UIColor.blue
        passcodeButton.color = testColor
        XCTAssertEqual(passcodeButton.backgroundColor, testColor)
    }

    func testImage() {
        XCTAssert(passcodeButton.image(for: .normal) == nil)

        let testImage = UIImage()
        passcodeButton.image = testImage
        XCTAssertEqual(passcodeButton.image(for: .normal), testImage)
        XCTAssertEqual(passcodeButton.imageView?.contentMode, .scaleAspectFit)
    }

    func testVisible() {
        passcodeButton.visible = true
        XCTAssertEqual(passcodeButton.alpha, 1.0)
        XCTAssertTrue(passcodeButton.isEnabled)

        passcodeButton.visible = false
        XCTAssertEqual(passcodeButton.alpha, 0.0)
        XCTAssertFalse(passcodeButton.isEnabled)
    }

    func testAnimateBackgroundColor() {
        let expectation = self.expectation(description: "Animation async")
        let testNewColor = UIColor.red
        passcodeButton.animateBackgroundColor(to: testNewColor, withDuration: 0.5) { _ in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertEqual(self.passcodeButton.backgroundColor, testNewColor)
        }
    }

    func testBeginTracking() {
        let testColor = UIColor.brown
        let expectation = self.expectation(description: "Animation async")
        passcodeButton.color = testColor
        _ = passcodeButton.beginTracking(UITouch(), with: nil)
        DispatchQueue.main.async {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertEqual(self.passcodeButton.backgroundColor, testColor)
        }
    }

    func testBeginTrackingWithAnnimation() {
        let testColor = UIColor.brown
        let testPressedColor = UIColor.cyan
        let expectation = self.expectation(description: "Animation async")
        passcodeButton.color = testColor
        passcodeButton.pressedColor = testPressedColor
        _ = passcodeButton.beginTracking(UITouch(), with: nil)
        DispatchQueue.main.async {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertEqual(self.passcodeButton.backgroundColor, testPressedColor)
        }
    }

    func testEndTracking() {
        let testColor = UIColor.brown
        let expectation = self.expectation(description: "Animation async")
        passcodeButton.color = testColor
        _ = passcodeButton.beginTracking(UITouch(), with: nil)
        _ = passcodeButton.endTracking(nil, with: nil)
        DispatchQueue.main.async {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertEqual(self.passcodeButton.backgroundColor, testColor)
        }
    }

    func testEndTrackingWithAnnimation() {
        let testColor = UIColor.brown
        let testPressedColor = UIColor.cyan
        let expectation = self.expectation(description: "Animation async")
        passcodeButton.color = testColor
        passcodeButton.pressedColor = testPressedColor
        _ = passcodeButton.beginTracking(UITouch(), with: nil)
        _ = passcodeButton.endTracking(nil, with: nil)
        DispatchQueue.main.async {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertEqual(self.passcodeButton.backgroundColor, testColor)
        }
    }
}
