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
        _ = passcodeGateway.hasPasscode
        XCTAssertTrue(passcodeRepositoryMock.didReferHasPasscode, "Failed to refer hasPasscode")
    }

    func testGetPasscode() {
        _ = passcodeGateway.getPasscode()
        XCTAssertTrue(passcodeRepositoryMock.didCallGetPasscode, "Faield to call getPasscode")
    }

    func testSavePasscode() {
        passcodeGateway.save("1234")

        XCTAssertNotNil(passcodeGateway.getPasscode(), "Faield to save passcode")
        XCTAssertTrue(passcodeUseCaseMock.didCallSavePasscode, "Faield to save passcode")
    }

    func testNotSavePasscode() {
        passcodeRepositoryMock.set(isSaved: false)
        passcodeGateway.save("1234")

        XCTAssertNil(passcodeGateway.getPasscode(), "Faield to not save passcode")
        XCTAssertTrue(passcodeUseCaseMock.didCallNotSavePasscode, "Faield to not save passcode")
    }

    func testDeletePasscode() {
        // prepare existing passcode
        passcodeGateway.save("1234")

        passcodeGateway.deletePasscode()

        XCTAssertNil(passcodeGateway.getPasscode(), "Faield to delete passcode")
        XCTAssertTrue(passcodeUseCaseMock.didCallDeletePasscode, "Faield to delete passcode")
    }

    func testNotDeletePasscode() {
        // prepare existing passcode
        passcodeGateway.save("1234")

        passcodeRepositoryMock.set(isDeleted: false)
        passcodeGateway.deletePasscode()

        XCTAssertNotNil(passcodeGateway.getPasscode(), "Faield to not delete passcode")
        XCTAssertTrue(passcodeUseCaseMock.didCallNotDeletePasscode, "Faield to not delete passcode")
    }
}
