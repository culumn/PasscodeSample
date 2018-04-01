//
//  PasscodePresenterTests.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSample

final class PasscodePresenterTests: XCTestCase {

    var passcodePresenter: PasscodePresenterImpl!
    var passcodeVCMock: PasscodeViewControllerMock!

    override func setUp() {
        super.setUp()

        passcodePresenter = PasscodePresenterImpl()
        passcodeVCMock = PasscodeViewControllerMock(expectation: self.expectation(description: "Async call in main thread"))

        passcodePresenter.delegate = passcodeVCMock
    }

    override func tearDown() {
        passcodePresenter = nil
        passcodeVCMock = nil

        super.tearDown()
    }

    func testDidSavePasscode() {
        passcodePresenter.didSavePasscode()

        waitForExpectations(timeout: 0.1) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallSavePasscode, "Failed to call didSavePasscode")
        }
    }

    func testDidNotSavePasscode() {
        passcodePresenter.didGet(error: .save)

        waitForExpectations(timeout: 0.1) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallGetError, "Failed to call didGetError")
        }
    }

    func testDidDeletePasscode() {
        passcodePresenter.didDeletePasscode()

        waitForExpectations(timeout: 0.1) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallDeletePasscode, "Failed to call didDeletePasscode")
        }
    }

    func testDidNotDeletePasscode() {
        passcodePresenter.didGet(error: .delete)

        waitForExpectations(timeout: 0.1) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallGetError, "Failed to call didGetError")
        }
    }

    func testDidTypePasscodeForFirstTime() {
        passcodePresenter.didTypePasscode(for: .enterFirstTime)

        waitForExpectations(timeout: 0.1) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallTypePasscode, "Failed to call didTypePasscode")
        }
    }
}
