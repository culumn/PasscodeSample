//
//  PasscodeGatewayTests.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSample

final class PasscodeGatewayTests: XCTestCase {

    var userDefaultsStorage: UserDefaultsStorage!
    var passcodeRepositoryMock: PasscodeRepositoryMock!
    var passcodeGateway: PasscodeGatewayImpl!
    var passcodeUseCaseMock: PasscodeUseCaseMock!
    
    override func setUp() {
        super.setUp()

        userDefaultsStorage = UserDefaultsStorage(domainName: Domain.test.rawValue)
        passcodeRepositoryMock = PasscodeRepositoryMock(userDefaultsStorage: userDefaultsStorage)
        passcodeGateway = PasscodeGatewayImpl(passcodeRepository: passcodeRepositoryMock)
        passcodeUseCaseMock = PasscodeUseCaseMock()

        passcodeGateway.delegate = passcodeUseCaseMock
    }
    
    override func tearDown() {
        try! userDefaultsStorage.deleteValue(forKey: .passcode)
        userDefaultsStorage = nil
        passcodeRepositoryMock = nil
        passcodeGateway = nil
        passcodeUseCaseMock = nil

        super.tearDown()
    }
    
    func testHasPasscode() {
        XCTAssert(passcodeGateway.getPasscode() == nil, "Should clear passcode")
        passcodeGateway.save("1234")
        XCTAssertTrue(passcodeGateway.hasPasscode, "Failed to compute hasPasscode")

        passcodeGateway.deletePasscode()
        XCTAssertFalse(passcodeGateway.hasPasscode, "Failed to compute hasPasscode")
    }

    func testGetPasscode() {
        passcodeGateway.save("1234")
        XCTAssertEqual(passcodeGateway.getPasscode(), "1234","Failed to get passcode")

        passcodeGateway.deletePasscode()
        XCTAssertNil(passcodeGateway.getPasscode(), "Failed to get passcode")
    }

    func testSavePasscode() {
        XCTAssert(passcodeGateway.getPasscode() == nil, "Should clear passcode")
        XCTAssert(!passcodeUseCaseMock.didCallSavePasscode, "Failed to reset flag")
        passcodeGateway.save("1234")

        XCTAssertNotNil(passcodeGateway.getPasscode(), "Failed to save passcode")
        XCTAssertEqual(passcodeGateway.getPasscode(), "1234")
        XCTAssertTrue(passcodeUseCaseMock.didCallSavePasscode, "Failed to save passcode")
    }

    func testNotSavePasscode() {
        XCTAssert(!passcodeUseCaseMock.didCallNotSavePasscode, "Failed to reset flag")
        passcodeRepositoryMock.set(isSaved: false)
        passcodeGateway.save("1234")

        XCTAssertNil(passcodeGateway.getPasscode(), "Failed to not save passcode")
        XCTAssertTrue(passcodeUseCaseMock.didCallNotSavePasscode, "Failed to not save passcode")
    }

    func testDeletePasscode() {
        // prepare existing passcode
        XCTAssert(!passcodeUseCaseMock.didCallDeletePasscode, "Failed to reset flag")
        passcodeGateway.save("1234")

        passcodeGateway.deletePasscode()
        XCTAssertNil(passcodeGateway.getPasscode(), "Failed to delete passcode")
        XCTAssertTrue(passcodeUseCaseMock.didCallDeletePasscode, "Failed to delete passcode")
    }

    func testNotDeletePasscode() {
        // prepare existing passcode
        XCTAssert(!passcodeUseCaseMock.didCallNotDeletePasscode, "Failed to reset flag")
        passcodeGateway.save("1234")

        passcodeRepositoryMock.set(isDeleted: false)
        passcodeGateway.deletePasscode()

        XCTAssertNotNil(passcodeGateway.getPasscode(), "Failed to not delete passcode")
        XCTAssertTrue(passcodeUseCaseMock.didCallNotDeletePasscode, "Failed to not delete passcode")
    }
}
