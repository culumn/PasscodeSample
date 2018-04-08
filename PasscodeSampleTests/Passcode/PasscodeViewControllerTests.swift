//
//  PasscodeViewControllerTests.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/04/07.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSample

final class PasscodeViewControllerTests: XCTestCase {

    var passcodeVC: PasscodeViewController!
    var passcodeControllerMock: PasscodeControllerMock!
    var numberButtons = [PasscodeButton]()

    override func setUp() {
        super.setUp()

        passcodeVC = PassscodeBuilder.build() as! PasscodeViewController
        passcodeControllerMock = PasscodeControllerMock()
        passcodeVC.controller = passcodeControllerMock
        UIApplication.shared.keyWindow?.rootViewController = passcodeVC

        for i in 0..<10 {
            let button = PasscodeButton()
            button.setTitle(String(i), for: .normal)
            numberButtons.append(button)
        }
    }
    
    override func tearDown() {
        passcodeVC = nil
        passcodeControllerMock = nil
        UIApplication.shared.keyWindow?.rootViewController = nil
        super.tearDown()
    }

    func testViewDidLoad() {
        passcodeVC.viewDidLoad()

        XCTAssertTrue(passcodeVC.message!.isEmpty)
    }

    func testMessage() {
        passcodeVC.message = "TestMessage"
        XCTAssertEqual(passcodeVC.messageLabel.text, "TestMessage")
        XCTAssertFalse(passcodeVC.messageLabel.isHidden)

        passcodeVC.message = ""
        XCTAssertEqual(passcodeVC.messageLabel.text, "")
        XCTAssertTrue(passcodeVC.messageLabel.isHidden)

        passcodeVC.message = nil
        XCTAssertNil(passcodeVC.messageLabel.text)
        XCTAssertTrue(passcodeVC.messageLabel.isHidden)
    }

    func testDidTapBiometricAuthenticationButton() {
        XCTAssert(!passcodeControllerMock.didCallEvaluateBiometricAuthentication)
        let button = PasscodeButton()
        passcodeVC.didTapBiometricAuthenticationButton(button)

        XCTAssertTrue(passcodeControllerMock.didCallEvaluateBiometricAuthentication)
    }

    func testDidTapDeleteButton() {
        let deleteButton = PasscodeButton()
        passcodeVC.passcode = "123"
        passcodeVC.didTapDeleteButton(deleteButton)
        XCTAssertEqual(passcodeVC.passcode, "12")

        passcodeVC.isAnimatingError = true
        passcodeVC.didTapDeleteButton(deleteButton)
        XCTAssertEqual(passcodeVC.passcode, "12")
    }

    func testDidTapNumberButton() {
        passcodeVC.didTapNumberButton(numberButtons[1])
        passcodeVC.didTapNumberButton(numberButtons[2])
        passcodeVC.didTapNumberButton(numberButtons[3])

        XCTAssertEqual(passcodeVC.passcode, "123")
    }

    func testDidTapNumberButtonWhenAnimating() {
        passcodeVC.isAnimatingError = true
        passcodeVC.didTapNumberButton(numberButtons[1])
        passcodeVC.didTapNumberButton(numberButtons[2])
        passcodeVC.didTapNumberButton(numberButtons[3])

        XCTAssertEqual(passcodeVC.passcode, "")
    }

    func testDidTapNumberButtonForTypeCurrentPasscode() {
        XCTAssert(!passcodeControllerMock.didCallTypeCurrentPasscode)

        passcodeVC.state = LockState(lockType: passcodeVC.state.lockType, inputType: .current)
        passcodeVC.passcode = "123"
        passcodeVC.didTapNumberButton(numberButtons[4])
        XCTAssertTrue(passcodeControllerMock.didCallTypeCurrentPasscode)
    }

    func testDidTapNumberButtonForTypeNewPasscode() {
        XCTAssert(!passcodeControllerMock.didCallTypeNewPasscode)

        passcodeVC.state = LockState(lockType: passcodeVC.state.lockType, inputType: .new)
        passcodeVC.passcode = "123"
        passcodeVC.didTapNumberButton(numberButtons[4])
        XCTAssertTrue(passcodeControllerMock.didCallTypeNewPasscode)
    }

    func testDidTapNumberButtonForConfirmNewPasscode() {
        XCTAssert(!passcodeControllerMock.didCallConfirmNewPasscode)

        passcodeVC.state = LockState(lockType: passcodeVC.state.lockType, inputType: .confirmation)
        passcodeVC.passcode = "123"
        passcodeVC.didTapNumberButton(numberButtons[4])
        XCTAssertTrue(passcodeControllerMock.didCallConfirmNewPasscode)
    }

    func testDidTapBottomButton() {
        let button = UnderlineTextButton()

        passcodeVC.didTapBottomButton(button)
        XCTAssertEqual(passcodeVC.passcode, "")
        XCTAssertEqual(passcodeVC.message, "")

        passcodeVC.state = LockState(lockType: .registration, inputType: .confirmation)
        passcodeVC.didTapBottomButton(button)
        XCTAssertEqual(passcodeVC.state.inputType, .new)

        passcodeVC.state = LockState(lockType: .login, inputType: .current)
        passcodeVC.didTapBottomButton(button)
        XCTAssertNotNil(passcodeVC.presentedViewController as? UIAlertController)

        passcodeVC.state = LockState(lockType: .change, inputType: .new)
        passcodeVC.didTapBottomButton(button)
        XCTAssertEqual(passcodeVC.state.inputType, .current)

        passcodeVC.state = LockState(lockType: .change, inputType: .confirmation)
        passcodeVC.didTapBottomButton(button)
        XCTAssertEqual(passcodeVC.state.inputType, .new)

        passcodeVC.state = LockState(lockType: .delete, inputType: .confirmation)
        passcodeVC.didTapBottomButton(button)
        XCTAssertEqual(passcodeVC.state.inputType, .current)
    }

    func testConfigureBiometricAuthenticationButton() {
        passcodeControllerMock.set(biometryType: .none)
        passcodeVC.configureBiometricAuthenticationButton()
        XCTAssertFalse(passcodeVC.biometricAuthenticationButton.visible)

        passcodeControllerMock.set(biometryType: .faceID)
        passcodeVC.configureBiometricAuthenticationButton()
        XCTAssertEqual(passcodeVC.biometricAuthenticationButton.image, #imageLiteral(resourceName: "FaceID"))

        passcodeControllerMock.set(biometryType: .touchID)
        passcodeVC.configureBiometricAuthenticationButton()
        XCTAssertEqual(passcodeVC.biometricAuthenticationButton.image, #imageLiteral(resourceName: "TouchID"))

        passcodeVC.state.lockType = .login
        passcodeControllerMock.set(availableBiometricAuthentication: true)
        passcodeVC.configureBiometricAuthenticationButton()
        XCTAssertTrue(passcodeVC.biometricAuthenticationButton.visible)

        passcodeVC.state.lockType = .login
        passcodeControllerMock.set(availableBiometricAuthentication: false)
        passcodeVC.configureBiometricAuthenticationButton()
        XCTAssertFalse(passcodeVC.biometricAuthenticationButton.visible)
    }

    func testUpdateView() {
        passcodeVC.updateView(title: "TestTitle", message: "TestMessage", buttonTitle: "TestButtonTitle")
        XCTAssertEqual(passcodeVC.titleLabel.text, "TestTitle")
        XCTAssertEqual(passcodeVC.message, "TestMessage")
        XCTAssertEqual(passcodeVC.bottomButton.title, "TestButtonTitle")
    }

    func testAnimateError() {
        passcodeVC.animateError()
        XCTAssertTrue(passcodeVC.isAnimatingError)
        XCTAssertEqual(passcodeVC.message, "Error")

        let expectation = self.expectation(description: "Async animation call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            XCTAssertFalse(self.passcodeVC.isAnimatingError)
            XCTAssertEqual(self.passcodeVC.passcode, "")
        }
    }

    func testCountRetry() {
        passcodeVC.state = LockState(lockType: .login, inputType: .current)
        passcodeVC.retryCount = 0
        passcodeVC.countRetry()
        XCTAssertEqual(passcodeVC.retryCount, 1)
    }
}
