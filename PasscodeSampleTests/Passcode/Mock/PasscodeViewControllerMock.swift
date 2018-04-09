//
//  PasscodeViewControllerMock.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSample

final class PasscodeViewControllerMock {

    let expectation: XCTestExpectation

    var didCallTypeNewPasscode = false
    var didCallTypeCurrentPasscode = false
    var didCallNotTypeCurrentPasscode = false
    var didCallNotConfirmPasscode = false
    var didCallCancellAuthenticateBiometrics = false
    var didCallNotAuthenticateBiometrics = false
    var didCallSavePasscode = false
    var didCallDeletePasscode = false
    var didCallGetError = false
    var didCallTypePasscode: Bool = false

    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
}

// MARK: - PasscodePresenterDelegate
extension PasscodeViewControllerMock: PasscodePresenterDelegate {

    func didTypeNewPasscode() {
        didCallTypeNewPasscode = true
        expectation.fulfill()
    }

    func didTypeCurrentPasscode() {
        didCallTypeCurrentPasscode = true
        expectation.fulfill()
    }

    func didNotTypeCurrentPasscode() {
        didCallNotTypeCurrentPasscode = true
        expectation.fulfill()
    }

    func didNotConfirmNewPasscode() {
        didCallNotConfirmPasscode = true
        expectation.fulfill()
    }

    func didCancellAuthenticateBiometrics() {
        didCallCancellAuthenticateBiometrics = true
        expectation.fulfill()
    }
    
    func didNotAuthenticateBiometrics() {
        didCallNotAuthenticateBiometrics = true
        expectation.fulfill()
    }

    func didSavePasscode() {
        didCallSavePasscode = true
        expectation.fulfill()
    }

    func didDeletePasscode() {
        didCallDeletePasscode = true
        expectation.fulfill()
    }

    func didGetError(with message: String) {
        didCallGetError = true
        expectation.fulfill()
    }
}
