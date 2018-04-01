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
    var didCallGetPasscode = false
    var didCallTypePasscode = false

    var didCallSavePasscode = false
    var didCallNotSavePasscode = false
    var didCallDeletePasscode = false
    var didCallNotDeletePasscode = false
}

// MARK: - PasscodeUseCase
extension PasscodeUseCaseMock: PasscodeUseCase {

    func evaluateBiometricAuthentication(isSuccess: Bool?, error: LAError?) {

    }

    var hasPasscode: Bool {
        didReferHasPasscode = true
        return true
    }

    func getPasscode() -> String? {
        didCallGetPasscode = true
        return ""
    }

    func save(_ passcode: String) {
        didCallSavePasscode = true
    }

    func deletePasscode() {
        didCallDeletePasscode = true
    }

    func type(_ passcode: String, for currentState: LockState) {
        didCallTypePasscode = true
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
