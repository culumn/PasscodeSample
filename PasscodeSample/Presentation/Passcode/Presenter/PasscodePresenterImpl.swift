//
//  PasscodePresenterImpl.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import LocalAuthentication

final class PasscodePresenterImpl {

    var delegate: PasscodePresenterDelegate?
}

// MARK: - PasscodePresenter
extension PasscodePresenterImpl: PasscodePresenter {
}

// MARK: - PasscodeUseCaseDelegate
extension PasscodePresenterImpl: PasscodeUseCaseDelegate {

    func didSavePasscode() {
        DispatchQueue.main.async {
            self.delegate?.didSavePasscode()
        }
    }

    func didDeletePasscode() {
        DispatchQueue.main.async {
            self.delegate?.didDeletePasscode()
        }
    }

    func didGet(error: PasscodeError) {
        var message = ""
        switch error {
        case .save:
            message = "Failed to save your passcode"
        case .delete:
            message = "Failed to delete your passcode"
        }

        DispatchQueue.main.async {
            self.delegate?.didGetError(with: message)
        }
    }

    func didNotAuthenticateBiometrics(with error: LAError) {
        DispatchQueue.main.async {
            switch error.code {
            case .userCancel, .appCancel, .systemCancel:
                self.delegate?.didCancellAuthenticateBiometrics()
            case .authenticationFailed:
                self.delegate?.didNotAuthenticateBiometrics()
            default:
                break
            }
        }
    }

    func didTypeNewPasscode() {
        DispatchQueue.main.async {
            self.delegate?.didTypeNewPasscode()
        }
    }

    func didTypeCurrentPasscode() {
        DispatchQueue.main.async {
            self.delegate?.didTypeCurrentPasscode()
        }
    }

    func didNotTypeCurrentPasscode() {
        DispatchQueue.main.async {
            self.delegate?.didNotTypeCurrentPasscode()
        }
    }

    func didNotConfirmNewPasscode() {
        DispatchQueue.main.async {
            self.delegate?.didNotConfirmNewPasscode()
        }
    }
}
