//
//  PasscodeUseCaseDelegate.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import LocalAuthentication

protocol PasscodeUseCaseDelegate: class {
    func didGet(error: PasscodeError)
    func didSavePasscode()
    func didDeletePasscode()
    func didNotAuthenticateBiometrics(with error: LAError)

    func didTypeNewPasscode()
    func didTypeCurrentPasscode()
    func didNotTypeCurrentPasscode()
    func didNotConfirmNewPasscode()
}
