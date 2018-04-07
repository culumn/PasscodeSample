//
//  HomeViewController.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController, UIAlertPresentable, PasscodeRoutable {

    var controller: PasscodeController!
    var passcodeRouter: PasscodeRouter!

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillEnterForeground(notification:)),
                                               name: .UIApplicationWillEnterForeground,
                                               object: nil)
    }

    @objc private func applicationWillEnterForeground(notification: Notification) {
        guard controller.hasPasscode else { return }
        passcodeRouter.login(from: self, presentCompletion: nil)
    }
}

// MARK: - IBActions
extension HomeViewController {

    @IBAction func didTapRegisterButton(_ sender: UIButton) {
        guard !controller.hasPasscode else { return presentOKAlert(title: "Error",
                                                                   message: "You don't have passcode yet.") }

        passcodeRouter.register(from: self, presentCompletion: nil)
    }

    @IBAction func didTapLoginButton(_ sender: UIButton) {
        guard controller.hasPasscode else { return presentOKAlert(title: "Error",
                                                                  message: "You don't have passcode yet.") }

        passcodeRouter.login(from: self, presentCompletion: nil)
    }

    @IBAction func didTapChangeButton(_ sender: UIButton) {
        guard controller.hasPasscode else { return presentOKAlert(title: "Error",
                                                                  message: "You don't have passcode yet.") }

        passcodeRouter.change(from: self, presentCompletion: nil)
    }

    @IBAction func didTapDeleteButton(_ sender: UIButton) {
        guard controller.hasPasscode else { return presentOKAlert(title: "Error",
                                                                  message: "You don't have passcode yet.") }

        passcodeRouter.delete(from: self, presentCompletion: nil)
    }
}
