//
//  PasscodeRouter.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import UIKit

final class PasscodeRouter {

    private init() {}

    static func register(from sourceVC: UIViewController) {
        guard let passcodeVC = PassscodeBuilder.build() as? PasscodeViewController else {
            preconditionFailure("Failed to generate PasscodeViewController")
        }
        passcodeVC.state = LockState(lockType: .registration, inputType: .new)

        sourceVC.present(passcodeVC, animated: true, completion: nil)
    }

    static func login(from sourceVC: UIViewController) {
        guard let passcodeVC = PassscodeBuilder.build() as? PasscodeViewController else {
            preconditionFailure("Failed to generate PasscodeViewController")
        }
        passcodeVC.state = LockState(lockType: .login, inputType: .current)

        sourceVC.present(passcodeVC, animated: true, completion: nil)
    }

    static func change(from sourceVC: UIViewController) {
        guard let passcodeVC = PassscodeBuilder.build() as? PasscodeViewController else {
            preconditionFailure("Failed to generate PasscodeViewController")
        }
        passcodeVC.state = LockState(lockType: .change, inputType: .current)

        sourceVC.present(passcodeVC, animated: true, completion: nil)
    }

    static func delete(from sourceVC: UIViewController) {
        guard let passcodeVC = PassscodeBuilder.build() as? PasscodeViewController else {
            preconditionFailure("Failed to generate PasscodeViewController")
        }
        passcodeVC.state = LockState(lockType: .delete, inputType: .current)

        sourceVC.present(passcodeVC, animated: true, completion: nil)
    }
}
