//
//  PasscodePresenterDelegate.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation

protocol PasscodePresenterDelegate: class {
    func didSavePasscode()
    func didDeletePasscode()
    func didGetError(with message: String)
    func didCancellAuthenticateBiometrics()
    func didNotAuthenticateBiometrics()

    func didTypeNewPasscode()
    func didTypeCurrentPasscode()
    func didNotTypeCurrentPasscode()
    func didNotConfirmNewPasscode()
}
