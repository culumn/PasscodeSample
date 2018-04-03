//
//  PasscodeUsecaseTests.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
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

    func testSavePasscode() {
        XCTAssertTrue(passcodeGatewayMock.didCallSavePasscode, "Failed to call savePasscode")
        XCTAssertNotNil(passcodeUseCase.getPasscode(), "Faield to save passcode")
        XCTAssertTrue(passcodePresenterMock.didCallSavePasscode, "Faield to save passcode")
    }

    func testNotSavePasscode() {
        passcodeRepositoryMock.set(isSaved: false)
        XCTAssertTrue(passcodeGatewayMock.didCallSavePasscode, "Failed to call notSavePasscode")
        XCTAssertNil(passcodeUseCase.getPasscode(), "Faield to not save passcode")
        XCTAssertTrue(passcodePresenterMock.didCallGetSaveError, "Faield to not save passcode")
    }

    func testDeletePasscode() {
        // prepare existing passcode
        XCTAssertTrue(passcodeGatewayMock.didCallDeletePasscode, "Failed to call deletePasscode")
        XCTAssertNil(passcodeUseCase.getPasscode(), "Faield to delete passcode")
        XCTAssertTrue(passcodePresenterMock.didCallDeletePasscode, "Faield to delete passcode")
    }

    func testNotDeletePasscode() {
        // prepare existing passcode
        passcodeRepositoryMock.set(isDeleted: false)

        XCTAssertTrue(passcodeGatewayMock.didCallDeletePasscode, "Failed to call notDeletePasscode")
        XCTAssertNotNil(passcodeUseCase.getPasscode(), "Faield to not delete passcode")
        XCTAssertTrue(passcodePresenterMock.didCallGetDeleteError, "Faield to not delete passcode")
    }

    func testTypePasscodeForFirstTime() {
        XCTAssertTrue(passcodePresenterMock.didCallTypePasscode, "Failed to type passcode")
    }
}
