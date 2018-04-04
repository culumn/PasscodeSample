//
//  PasscodeUseCaseImpl.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import LocalAuthentication

final class PasscodeUseCaseImpl {

    let passcodeGateway: PasscodeGateway
    var delegate: PasscodeUseCaseDelegate?
    var tempPasscode = ""

    init(passcodeGateway: PasscodeGateway) {
        self.passcodeGateway = passcodeGateway
    }
}

// MARK: - PasscodeUseCase
extension PasscodeUseCaseImpl: PasscodeUseCase {

    var hasPasscode: Bool {
        return passcodeGateway.hasPasscode
    }

    func getPasscode() -> String? {
        return passcodeGateway.getPasscode()
    }

    func evaluateBiometricAuthentication(isSuccess: Bool?, error: LAError?) {
        guard let error = error else {
            precondition(isSuccess!)
            delegate?.didTypeCurrentPasscode()
            return
        }

        delegate?.didNotAuthenticateBiometrics(with: error)
    }

    func type(currentPasscode: String, for lockType: LockType) {
        guard let storedPasscode = passcodeGateway.getPasscode(),
            currentPasscode == storedPasscode
        else {
            delegate?.didNotTypeCurrentPasscode()
            return
        }

        switch lockType {
        case .registration:
            break
        case .login, .change, .delete:
            delegate?.didTypeCurrentPasscode()
        }
    }

    func type(newPasscode: String, for lockType: LockType) {
        tempPasscode = newPasscode

        delegate?.didTypeNewPasscode()
    }

    func confirmPasscode(using passcode: String, for lockType: LockType) {
        switch lockType {
        case .registration, .change:
            guard tempPasscode == passcode else {
                delegate?.didNotConfirmNewPasscode()
                return
            }
            passcodeGateway.save(passcode)
        case .login:
            break
        case .delete:
            guard let storedPasscode = passcodeGateway.getPasscode(),
                passcode == storedPasscode
            else {
                delegate?.didNotConfirmNewPasscode()
                return
            }
            passcodeGateway.deletePasscode()
        }
    }
}

// MARK: - PasscodeGatewayDelegate
extension PasscodeUseCaseImpl: PasscodeGatewayDelegate {

    func didSavePasscode() {
        delegate?.didSavePasscode()
    }

    func didNotSavePasscode() {
        delegate?.didGet(error: .save)
    }

    func didDeletePasscode() {
        delegate?.didDeletePasscode()
    }

    func didNotDeletePasscode() {
        delegate?.didGet(error: .delete)
    }
}
