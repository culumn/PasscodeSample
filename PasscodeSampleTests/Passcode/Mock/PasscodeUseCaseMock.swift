//
//  PasscodeUseCaseMock.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
import LocalAuthentication
@testable import PasscodeSample

final class PasscodeUseCaseMock {

    var delegate: PasscodeUseCaseDelegate?

    var didReferHasPasscode = false
    var didCallTypeCurrentPasscode = false
    var didCallTypeNewPasscode = false
    var didCallConfirmPasscode = false
    var didCallEvaluateBiometricAuthentication = false

    var didCallSavePasscode = false
    var didCallNotSavePasscode = false
    var didCallDeletePasscode = false
    var didCallNotDeletePasscode = false
}

// MARK: - PasscodeUseCase
extension PasscodeUseCaseMock: PasscodeUseCase {

    func type(currentPasscode: String, for lockType: LockType) {
        didCallTypeCurrentPasscode = true
    }

    func type(newPasscode: String, for lockType: LockType) {
        didCallTypeNewPasscode = true
    }

    func confirmPasscode(using passcode: String, for lockType: LockType) {
        didCallConfirmPasscode = true
    }

    func evaluateBiometricAuthentication(isSuccess: Bool?, error: LAError?) {
        didCallEvaluateBiometricAuthentication = true
    }

    var hasPasscode: Bool {
        didReferHasPasscode = true
        return true
    }
}

// MARK: - PasscodeGatewayDelegate
extension PasscodeUseCaseMock: PasscodeGatewayDelegate {

    func didSavePasscode() {
        didCallSavePasscode = true
    }

    func didNotSavePasscode() {
        didCallNotSavePasscode = true
    }

    func didDeletePasscode() {
        didCallDeletePasscode = true
    }

    func didNotDeletePasscode() {
        didCallNotDeletePasscode = true
    }
}
