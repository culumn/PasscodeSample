//
//  PasscodeUseCase.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import LocalAuthentication

protocol PasscodeUseCase: class {
    var delegate: PasscodeUseCaseDelegate? { get set }

    var hasPasscode: Bool { get }
    func evaluateBiometricAuthentication(isSuccess: Bool?, error: LAError?)
    func type(currentPasscode: String, for lockType: LockType)
    func type(newPasscode: String, for lockType: LockType)
    func confirmNewPasscode(using passcode: String, for lockType: LockType)
}
