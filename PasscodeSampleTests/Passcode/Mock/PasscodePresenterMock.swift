//
//  PasscodePresenterMock.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import LocalAuthentication
@testable import PasscodeSample

final class PasscodePresenterMock {

    var didCallSavePasscode = false
    var didCallDeletePasscode = false
    var didCallGetSaveError = false
    var didCallGetDeleteError = false
    var didCallTypePasscode = false
}

// MARK: - PasscodePresenter
extension PasscodePresenterMock: PasscodeUseCaseDelegate {

    func didTypeNewPasscode() {

    }

    func didTypeCurrentPasscode() {

    }

    func didNotTypeCurrentPasscode() {

    }

    func didNotConfirmNewPasscode() {
        
    }

    func didNotAuthenticateBiometrics(with error: LAError) {

    }

    func didSavePasscode() {
        didCallSavePasscode = true
    }

    func didDeletePasscode() {
        didCallDeletePasscode = true
    }

    func didGet(error: PasscodeError) {
        switch error {
        case .save:
            didCallGetSaveError = true
        case .delete:
            didCallGetDeleteError = true
        }
    }
}
