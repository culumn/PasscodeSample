//
//  PasscodeUsecaseTests.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
import LocalAuthentication
@testable import PasscodeSample

final class PasscodeUsecaseTests: XCTestCase {

    var userDefaultsStorage: UserDefaultsStorage!
    var passcodeRepositoryMock: PasscodeRepositoryMock!
    var passcodeGatewayMock: PasscodeGatewayMock!
    var passcodeUseCase: PasscodeUseCaseImpl!
    var passcodePresenterMock: PasscodePresenterMock!
    
    override func setUp() {
        super.setUp()

        userDefaultsStorage = UserDefaultsStorage(domainName: Domain.test.rawValue)
        passcodeRepositoryMock = PasscodeRepositoryMock(userDefaultsStorage: userDefaultsStorage)
        passcodeGatewayMock = PasscodeGatewayMock(passcodeRepository: passcodeRepositoryMock)
        passcodeUseCase = PasscodeUseCaseImpl(passcodeGateway: passcodeGatewayMock)
        passcodePresenterMock = PasscodePresenterMock()

        passcodeGatewayMock.delegate = passcodeUseCase
        passcodeUseCase.delegate = passcodePresenterMock
    }
    
    override func tearDown() {
        try! userDefaultsStorage.deleteValue(forKey: .passcode)
        userDefaultsStorage = nil
        passcodeRepositoryMock = nil
        passcodeGatewayMock = nil
        passcodeUseCase = nil
        passcodePresenterMock = nil

        super.tearDown()
    }

    func testHasPasscode() {
        _ = passcodeUseCase.hasPasscode
        XCTAssertTrue(passcodeGatewayMock.didReferHasPasscode, "Failed to refer hasPasscode")
    }

    func testGetPasscode() {
        _ = passcodeUseCase.getPasscode()
        XCTAssertTrue(passcodeGatewayMock.didCallGetPasscode, "Failed to call getPasscode")
    }

    func testTypeNewPasscode() {
        passcodeUseCase.type(newPasscode: "1234", for: .registration)

        XCTAssertEqual(passcodeUseCase.tempPasscode, "1234", "Faield to set temp passcode when type new passcode")
        XCTAssertTrue(passcodePresenterMock.didCallTypeNewPasscode)
    }

    func testTypeCurrentPasscode() {
        // prepare existing passcode
        XCTAssert(!passcodePresenterMock.didCallTypeCurrentPasscode, "Failed to reset flag")
        passcodeGatewayMock.save("1234")

        passcodeUseCase.type(currentPasscode: "1234", for: .login)

        XCTAssertTrue(passcodePresenterMock.didCallTypeCurrentPasscode)
    }

    func testNotTypeCurrentPasscode() {
        // prepare existing passcode
        XCTAssert(!passcodePresenterMock.didCallNotTypeCurrentPasscode, "Failed to reset flag")
        passcodeGatewayMock.save("1234")

        passcodeUseCase.type(currentPasscode: "5678", for: .login)

        XCTAssertTrue(passcodePresenterMock.didCallNotTypeCurrentPasscode)
    }

    func testConfirmPasscodeForRegistration() {
        XCTAssert(!passcodeGatewayMock.didCallSavePasscode, "Failed to reset flag")
        passcodeUseCase.type(newPasscode: "1234", for: .registration)

        passcodeUseCase.confirmPasscode(using: "1234", for: .registration)

        XCTAssertTrue(passcodeGatewayMock.didCallSavePasscode)
    }

    func testConfirPasscodeForChange() {
        XCTAssert(!passcodeGatewayMock.didCallSavePasscode, "Failed to reset flag")
        passcodeUseCase.type(newPasscode: "1234", for: .change)

        passcodeUseCase.confirmPasscode(using: "1234", for: .change)

        XCTAssertTrue(passcodeGatewayMock.didCallSavePasscode)
    }

    func testNotConfirmPasscode() {
        XCTAssert(!passcodePresenterMock.didCallNotConfirmPasscode, "Failed to reset flag")
        passcodeUseCase.type(newPasscode: "1234", for: .registration)

        passcodeUseCase.confirmPasscode(using: "5678", for: .registration)

        XCTAssertTrue(passcodePresenterMock.didCallNotConfirmPasscode)
    }

    func testConfirmPasscodeForDelete() {
        // prepare existing passcode
        XCTAssert(!passcodeGatewayMock.didCallDeletePasscode, "Failed to reset flag")
        passcodeGatewayMock.save("1234")

        passcodeUseCase.confirmPasscode(using: "1234", for: .delete)

        XCTAssertTrue(passcodeGatewayMock.didCallDeletePasscode)
    }

    func testNotConfirmPasscodeForDelete() {
        // prepare existing passcode
        XCTAssert(!passcodePresenterMock.didCallNotConfirmPasscode, "Failed to reset flag")
        passcodeGatewayMock.save("1234")

        passcodeUseCase.confirmPasscode(using: "5678", for: .delete)

        XCTAssertTrue(passcodePresenterMock.didCallNotConfirmPasscode)
    }

    func testEvaluateBiometricAuthentication() {
        XCTAssert(!passcodePresenterMock.didCallTypeCurrentPasscode, "Failed to reset flag")
        passcodeUseCase.evaluateBiometricAuthentication(isSuccess: true, error: nil)

        XCTAssertTrue(passcodePresenterMock.didCallTypeCurrentPasscode)
    }

    func testNotAuthenticateBiometrics() {
        XCTAssert(!passcodePresenterMock.didCallNotAuthenticateBiometrics, "Failed to reset flag")
        let nsError = NSError(domain: LAErrorDomain, code: Int(kLAErrorAppCancel), userInfo: [:])
        passcodeUseCase.evaluateBiometricAuthentication(isSuccess: false, error: LAError(_nsError: nsError))

        XCTAssertTrue(passcodePresenterMock.didCallNotAuthenticateBiometrics)
    }

    func testDidSavePasscode() {
        XCTAssert(!passcodePresenterMock.didCallSavePasscode, "Failed to reset flag")

        passcodeUseCase.didSavePasscode()

        XCTAssertTrue(passcodePresenterMock.didCallSavePasscode)
    }

    func testDidNotSavePasscode() {
        XCTAssert(!passcodePresenterMock.didCallGetSaveError, "Failed to reset flag")
        passcodeUseCase.didNotSavePasscode()

        XCTAssertTrue(passcodePresenterMock.didCallGetSaveError)
    }

    func testDidNDeletePasscode() {
        XCTAssert(!passcodePresenterMock.didCallDeletePasscode, "Failed to reset flag")
        passcodeUseCase.didDeletePasscode()

        XCTAssertTrue(passcodePresenterMock.didCallDeletePasscode)
    }

    func testDidNotDeletePasscode() {
        XCTAssert(!passcodePresenterMock.didCallGetDeleteError, "Failed to reset flag")
        passcodeUseCase.didNotDeletePasscode()

        XCTAssertTrue(passcodePresenterMock.didCallGetDeleteError)
    }
}
