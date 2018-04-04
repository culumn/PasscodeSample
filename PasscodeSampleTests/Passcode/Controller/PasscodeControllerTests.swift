//
//  PasscodeLoginControllerTests.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSample

final class PasscodeControllerTests: XCTestCase {

    var passcodeUseCaseMock: PasscodeUseCaseMock!
    var passcodeController: PasscodeControllerImpl!

    override func setUp() {
        super.setUp()

        passcodeUseCaseMock = PasscodeUseCaseMock()
        passcodeController = PasscodeControllerImpl(passcodeUseCase: passcodeUseCaseMock)
    }

    override func tearDown() {
        passcodeUseCaseMock = nil
        passcodeController = nil

        super.tearDown()
    }

    func testHasPassode() {
        _ = passcodeController.hasPasscode

        XCTAssertTrue(passcodeUseCaseMock.didReferHasPasscode, "Failed to refer hasPasscode")
    }

    func testAvailableBiometricAuthentication() {
        XCTAssertFalse(passcodeController.availableBiometricAuthentication)
    }

    func testBiometryType() {
        XCTAssertEqual(passcodeController.biometryType, .none)
    }

    func testEvaluateBiometricAuthentication() {
        XCTAssert(!passcodeUseCaseMock.didCallEvaluateBiometricAuthentication, "Failed to clear flag")

        passcodeController.evaluateBiometricAuthentication(localizedReason: "Use biometric authentication for test")
        XCTAssertFalse(passcodeUseCaseMock.didCallEvaluateBiometricAuthentication)
    }

    func testTypeCurrentPasscode() {
        XCTAssert(!passcodeUseCaseMock.didCallTypeCurrentPasscode, "Failed to clear flag")

        passcodeController.type(currentPasscode: "1234", for: .login)
        XCTAssertTrue(passcodeUseCaseMock.didCallTypeCurrentPasscode)
    }

    func testTypeNewPasscode() {
        XCTAssert(!passcodeUseCaseMock.didCallTypeNewPasscode, "Failed to clear flag")

        passcodeController.type(newPasscode: "1234", for: .registration)
        XCTAssertTrue(passcodeUseCaseMock.didCallTypeNewPasscode)
    }

    func testConfirmNewPasscode() {
        XCTAssert(!passcodeUseCaseMock.didCallConfirmPasscode, "Failed to clear flag")

        passcodeController.confirmNewPasscode(using: "1234", for: .registration)
        XCTAssertTrue(passcodeUseCaseMock.didCallConfirmPasscode)
    }
}
