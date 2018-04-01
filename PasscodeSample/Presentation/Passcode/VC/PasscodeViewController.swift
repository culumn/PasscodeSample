//
//  ViewController.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import UIKit
import AudioToolbox

final class PasscodeViewController: UIViewController, UIAlertPresentable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var bottomButton: UnderlineTextButton!
    @IBOutlet weak var biometricAuthenticationButton: PasscodeButton!

    @IBOutlet var placeholders: [PasscodePlaceholderView]!
    @IBOutlet weak var placeholdersHorizontalConstraint: NSLayoutConstraint!

    var state = LockState()
    var controller: PasscodeController!

    private var passcode: String = ""
    private var message: String? = "" {
        didSet {
            messageLabel.text = message
            messageLabel.isHidden = message?.isEmpty ?? true
        }
    }
    private var isAnimatingError = false
    private var retryCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
}

// MARK: - IBActions
extension PasscodeViewController {

    @IBAction func didTapNumberButton(_ sender: PasscodeButton) {
        guard !isAnimatingError &&
            passcode.count <= AppConfig.passcodeLength - 1 else { return }

        passcode += (sender.title(for: .normal) ?? "")

        let index = passcode.count - 1
        placeholders[index].fillColor()

        guard passcode.count >= AppConfig.passcodeLength else { return }
        switch state.inputType {
        case .current:
            controller.type(currentPasscode: passcode, for: state.lockType)
        case .new:
            controller.type(newPasscode: passcode, for: state.lockType)
        case .confirmation:
            controller.confirmNewPasscode(using: passcode, for: state.lockType)

        }
    }

    @IBAction func didTapDeleteButton(_ sender: PasscodeButton) {
        guard !passcode.isEmpty &&
            !isAnimatingError else { return }
        passcode.removeLast()

        let index = passcode.count
        placeholders[index].fillEmpty()
    }

    @IBAction func biometricAuthenticationButton(_ sender: PasscodeButton) {
        controller.evaluateBiometricAuthentication(localizedReason: "Use authentication for unlock")
    }

    @IBAction func didTapBottomButton(_ sender: UnderlineTextButton) {
        switch state.lockType {
        case .registration where state.inputType == .new:
            dismiss(animated: true)
        case .registration where state.inputType == .confirmation:
            state.inputType = .new
            updateView()
        case .login:
            presentOKAlert(title: "Message", message: "Doesn't implement this function") { action in
                self.dismiss(animated: true)
            }
        case .change where state.inputType == .current:
            dismiss(animated: true)
        case .change where state.inputType == .new:
            state.inputType = .current
            updateView()
        case .change where state.inputType == .confirmation:
            state.inputType = .new
            updateView()
        case .delete where state.inputType == .current:
            dismiss(animated: true)
        case .delete where state.inputType == .confirmation:
            state.inputType = .current
            updateView()
        default:
            break
        }

        passcode = ""
        message = ""
        fillEmptyPlaceholders()
    }
}

// MARK: - Private function
extension PasscodeViewController {

    private func configure() {
        updateView()
        message = ""
    }

    private func configureBiometricAuthenticationButton() {
        biometricAuthenticationButton.visible = controller.availableBiometricAuthentication &&
            state.lockType == .login

        switch controller.biometryType {
        case .faceID:
            biometricAuthenticationButton.image = #imageLiteral(resourceName: "FaceID")
        case .touchID:
            biometricAuthenticationButton.image = #imageLiteral(resourceName: "TouchID")
        case .none:
            biometricAuthenticationButton.visible = false
        }
    }

    private func updateView(title: String? = nil,
                            message: String? = nil,
                            buttonTitle: String? = nil) {
        switch state.lockType {
        case .registration where state.inputType == .new:
            titleLabel.text = "Enter passcode to register"
            bottomButton.title = "Cancel"
        case .registration where state.inputType == .confirmation:
            titleLabel.text = "Enter passcode again"
            bottomButton.title = "Cancel"
        case .login:
            titleLabel.text = "Enter current passcode to login"
            bottomButton.title = "Forget passcode"
        case .change where state.inputType == .current:
            titleLabel.text = "Enter current passcode to change"
            bottomButton.title = "Cancel"
        case .change where state.inputType == .new:
            titleLabel.text = "Enter new passcode"
            bottomButton.title = "Cancel"
        case .change where state.inputType == .confirmation:
            titleLabel.text = "Enter new passcode again"
            bottomButton.title = "Cancel"
        case .delete where state.inputType == .current:
            titleLabel.text = "Enter current passcode to delete"
            bottomButton.title = "Cancel"
        case .delete where state.inputType == .confirmation:
            titleLabel.text = "Enter current passcode again"
            bottomButton.title = "Cancel"
        default:
            break
        }

        if let title = title {
            titleLabel.text = title
        }
        if let message = message {
            self.message = message
        }
        if let buttonTitle = buttonTitle {
            bottomButton.title = buttonTitle
        }

        configureBiometricAuthenticationButton()
    }

    private func fillEmptyPlaceholders() {
        for placeholder in placeholders {
            placeholder.fillEmpty()
        }
    }

    private func animateError() {
        isAnimatingError = true

        message = "Error"
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)

        for placeholder in self.placeholders {
            placeholder.fillErrorColor()
        }

        placeholdersHorizontalConstraint.constant = -20
        view.layoutIfNeeded()

        UIView.animate(withDuration: 0.6,
                       delay: 0.0,
                       usingSpringWithDamping: 0.05,
                       initialSpringVelocity: 2,
                       options: [],
                       animations: {
                        self.placeholdersHorizontalConstraint.constant = 0
                        self.view.layoutIfNeeded()
        }) { isFinished in
            self.passcode = ""
            self.fillEmptyPlaceholders()
            self.isAnimatingError = false
        }
    }

    private func fillPlaceholders() {
        for placeholder in placeholders {
            placeholder.fillColor()
        }
    }

    private func countRetry() {
        guard state.lockType != .registration else { return }
        guard !(state.inputType == .new && state.inputType == .confirmation) else { return }
        retryCount += 1
        guard retryCount >= AppConfig.maxRetryCount else { return }
        presentOKAlert(title: "Error", message: "You exceeded max retry count") { action in
            self.dismiss(animated: true)
        }
    }
}

// MARK: - PasscodePresenterDelegate
extension PasscodeViewController: PasscodePresenterDelegate {

    func didSavePasscode() {
        fillEmptyPlaceholders()
        presentOKAlert(title: "Result", message: "Succeeded to save your passcode") { action in
            self.dismiss(animated: true)
        }
    }

    func didDeletePasscode() {
        fillEmptyPlaceholders()
        presentOKAlert(title: "Result", message: "Succeeded to delete your passcode") { action in
            self.dismiss(animated: true)
        }
    }

    func didGetError(with message: String) {
        presentOKAlert(title: "Error", message: message) { _ in
            self.dismiss(animated: true)
        }
    }

    func didAuthenticateBiometrics() {
        fillPlaceholders()
        presentOKAlert(title: "Result", message: "Succeeded to login") { action in
            self.dismiss(animated: true)
        }
    }

    func didCancellAuthenticateBiometrics() {
    }

    func didNotAuthenticateBiometrics() {
        animateError()
    }

    func didTypeNewPasscode() {
        passcode = ""
        retryCount = 0
        fillEmptyPlaceholders()

        switch state.lockType {
        case .change, .registration:
            state.inputType = .confirmation
        default:
            break
        }

        updateView(message: "")
    }

    func didTypeCurrentPasscode() {
        passcode = ""
        retryCount = 0

        switch state.lockType {
        case .login:
            presentOKAlert(title: "Result", message: "You entered passcode Successfully") { action in
                self.dismiss(animated: true)
            }
        case .change:
            state.inputType = .new
            fillEmptyPlaceholders()
        case .delete:
            state.inputType = .confirmation
            fillEmptyPlaceholders()
        case .registration:
            break
        }
        updateView(message: "")
    }

    func didNotTypeCurrentPasscode() {
        passcode = ""
        animateError()
        countRetry()
        updateView(message: "You entered wrong passcode: \(retryCount) time")
    }

    func didNotConfirmNewPasscode() {
        passcode = ""
        animateError()
        let message = retryCount == 0 ? "You entered wrong passcode" : "You typed wrong passcode: \(retryCount) time"
        updateView(message: message)
    }
}
