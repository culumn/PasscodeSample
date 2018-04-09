//
//  PasscodePresenterTests.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
import LocalAuthentication
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
        XCTAssert(!passcodeVCMock.didCallSavePasscode, "Failed to clear flag")
        passcodePresenter.didSavePasscode()

        waitForExpectations(timeout: 0.2) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallSavePasscode)
        }
    }

    func testDidNotSavePasscode() {
        XCTAssert(!passcodeVCMock.didCallGetError, "Failed to clear flag")
        passcodePresenter.didGet(error: .save)

        waitForExpectations(timeout: 0.2) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallGetError)
        }
    }

    func testDidDeletePasscode() {
        XCTAssert(!passcodeVCMock.didCallDeletePasscode, "Failed to clear flag")
        passcodePresenter.didDeletePasscode()

        waitForExpectations(timeout: 0.2) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallDeletePasscode)
        }
    }

    func testDidNotDeletePasscode() {
        XCTAssert(!passcodeVCMock.didCallGetError, "Failed to clear flag")
        passcodePresenter.didGet(error: .delete)

        waitForExpectations(timeout: 0.2) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallGetError)
        }
    }

    func testDidNotAuthenticateBiometricsWhenFailure() {
        XCTAssert(!passcodeVCMock.didCallNotAuthenticateBiometrics, "Failed to clear flag")
        let failureError = NSError(domain: LAErrorDomain, code: Int(kLAErrorAuthenticationFailed), userInfo: [:])
        passcodePresenter.didNotAuthenticateBiometrics(with: LAError(_nsError: failureError))

        waitForExpectations(timeout: 0.2) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallNotAuthenticateBiometrics)
        }
    }

    func testDidNotAuthenticateBiometricsWhenCancel() {
        XCTAssert(!passcodeVCMock.didCallCancellAuthenticateBiometrics, "Failed to clear flag")
        let cancelError = NSError(domain: LAErrorDomain, code: Int(kLAErrorAppCancel), userInfo: [:])
        passcodePresenter.didNotAuthenticateBiometrics(with: LAError(_nsError: cancelError))

        waitForExpectations(timeout: 0.2) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallCancellAuthenticateBiometrics)
        }
    }

    func testDidTypeNewPasscode() {
        XCTAssert(!passcodeVCMock.didCallTypeNewPasscode, "Failed to clear flag")
        passcodePresenter.didTypeNewPasscode()

        waitForExpectations(timeout: 0.2) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallTypeNewPasscode)
        }
    }

    func testDidTypeCurrentPasscode() {
        XCTAssert(!passcodeVCMock.didCallTypeCurrentPasscode, "Failed to clear flag")
        passcodePresenter.didTypeCurrentPasscode()

        waitForExpectations(timeout: 0.2) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallTypeCurrentPasscode)
        }
    }

    func testDidNotTypeCurrentPasscode() {
        XCTAssert(!passcodeVCMock.didCallNotTypeCurrentPasscode, "Failed to clear flag")
        passcodePresenter.didNotTypeCurrentPasscode()

        waitForExpectations(timeout: 0.2) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallNotTypeCurrentPasscode)
        }
    }

    func testDidNotConfirmNewPasscode() {
        XCTAssert(!passcodeVCMock.didCallNotConfirmPasscode, "Failed to clear flag")
        passcodePresenter.didNotConfirmNewPasscode()

        waitForExpectations(timeout: 0.2) { error in
            XCTAssertTrue(self.passcodeVCMock.didCallNotConfirmPasscode)
        }
    }
}
