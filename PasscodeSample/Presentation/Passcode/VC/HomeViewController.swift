//
//  HomeViewController.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController, UIAlertPresentable {

    var controller: PasscodeController!

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillEnterForeground(notification:)),
                                               name: .UIApplicationWillEnterForeground,
                                               object: nil)
    }

    @objc private func applicationWillEnterForeground(notification: Notification) {
        guard controller.hasPasscode else { return }
        guard let passcodeVC = PassscodeBuilder.build() as? PasscodeViewController else { return }
        passcodeVC.state = LockState(lockType: .login, inputType: .current)
        PasscodeRouter.login(from: self)
    }
}

// MARK: - IBActions
extension HomeViewController {

    @IBAction func didTapRegisterButton(_ sender: UIButton) {
        guard !controller.hasPasscode else { return presentOKAlert(title: "Error",
                                                                   message: "You don't have passcode yet.") }

        PasscodeRouter.register(from: self)
    }

    @IBAction func didTapLoginButton(_ sender: UIButton) {
        guard controller.hasPasscode else { return presentOKAlert(title: "Error",
                                                                  message: "You don't have passcode yet.") }

        PasscodeRouter.login(from: self)
    }

    @IBAction func didTapChangeButton(_ sender: UIButton) {
        guard controller.hasPasscode else { return presentOKAlert(title: "Error",
                                                                  message: "You don't have passcode yet.") }

        PasscodeRouter.change(from: self)
    }

    @IBAction func didTapDeleteButton(_ sender: UIButton) {
        guard controller.hasPasscode else { return presentOKAlert(title: "Error",
                                                                  message: "You don't have passcode yet.") }

        PasscodeRouter.delete(from: self)
    }
}
