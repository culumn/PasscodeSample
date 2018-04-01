//
//  PasscodeControllerImpl.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import LocalAuthentication

final class PasscodeControllerImpl {

    let passcodeUseCase: PasscodeUseCase

    init(passcodeUseCase: PasscodeUseCase) {
        self.passcodeUseCase = passcodeUseCase
    }
}

// MARK: - PasscodeController
extension PasscodeControllerImpl: PasscodeController {

    var hasPasscode: Bool {
        return passcodeUseCase.hasPasscode
    }

    var availableBiometricAuthentication: Bool {
        return LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }

    var biometryType: LABiometryType {
        return LAContext().biometryType
    }

    func type(currentPasscode: String, for lockType: LockType) {
        precondition(currentPasscode.count == AppConfig.passcodeLength, "Passcode length is not appropriate")
        passcodeUseCase.type(currentPasscode: currentPasscode, for: lockType)
    }

    func type(newPasscode: String, for lockType: LockType) {
        precondition(newPasscode.count == AppConfig.passcodeLength, "Passcode length is not appropriate")
        passcodeUseCase.type(newPasscode: newPasscode, for: lockType)
    }

    func confirmNewPasscode(using passcode: String, for lockType: LockType) {
        precondition(passcode.count == AppConfig.passcodeLength, "Passcode length is not appropriate")
        passcodeUseCase.confirmNewPasscode(using: passcode, for: lockType)
    }

    func evaluateBiometricAuthentication(localizedReason: String) {
        let context = LAContext()
        context.localizedFallbackTitle = ""
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason) { isSuccess, error in
            self.passcodeUseCase.evaluateBiometricAuthentication(isSuccess: isSuccess, error: error as? LAError)
        }
    }
}
