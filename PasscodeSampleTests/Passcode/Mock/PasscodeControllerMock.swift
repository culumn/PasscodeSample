//
//  PasscodeControllerMock.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/04/08.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import LocalAuthentication
@testable import PasscodeSample

final class PasscodeControllerMock {

    var didCallEvaluateBiometricAuthentication = false
    var didCallTypeCurrentPasscode = false
    var didCallTypeNewPasscode = false
    var didCallConfirmNewPasscode = false

    private var _biometryType = LABiometryType.none
    private var _availableBiometricAuthentication = false
}

// MARK: - PasscodeController
extension PasscodeControllerMock: PasscodeController {

    var hasPasscode: Bool {
        return true
    }

    var availableBiometricAuthentication: Bool {
        return _availableBiometricAuthentication
    }

    var biometryType: LABiometryType {
        return _biometryType
    }

    func evaluateBiometricAuthentication(localizedReason: String) {
        didCallEvaluateBiometricAuthentication = true
    }

    func type(currentPasscode: String, for lockType: LockType) {
        didCallTypeCurrentPasscode = true
    }

    func type(newPasscode: String, for lockType: LockType) {
        didCallTypeNewPasscode = true
    }

    func confirmNewPasscode(using passcode: String, for lockType: LockType) {
        didCallConfirmNewPasscode = true
    }
}

// MARK: - Helper
extension PasscodeControllerMock {

    func set(biometryType: LABiometryType) {
        _biometryType = biometryType
    }

    func set(availableBiometricAuthentication: Bool) {
        _availableBiometricAuthentication = availableBiometricAuthentication
    }
}
