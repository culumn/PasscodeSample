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

    }

    func didTypeCurrentPasscode() {

    }

    func didNotTypeCurrentPasscode() {

    }

    func didNotConfirmNewPasscode() {

    }

    func didCancellAuthenticateBiometrics() {

    }
    
    func didNotAuthenticateBiometrics() {

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
