//
//  PasscodeController.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import LocalAuthentication

protocol PasscodeController: class {
    var hasPasscode: Bool { get }
    var availableBiometricAuthentication: Bool { get }
    var biometryType: LABiometryType { get }

    func evaluateBiometricAuthentication(localizedReason: String)
    func type(currentPasscode: String, for lockType: LockType)
    func type(newPasscode: String, for lockType: LockType)
    func confirmNewPasscode(using passcode: String, for lockType: LockType)
}
