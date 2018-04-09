//
//  PasscodeRepositoryTests.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSample

final class PasscodeRepositoryTests: XCTestCase {

    var userDefaultsStorage: UserDefaultsStorage!
    var passcodeRepository: PasscodeRepositoryImpl!
    
    override func setUp() {
        super.setUp()

        userDefaultsStorage = UserDefaultsStorage(domainName: Domain.test.rawValue)
        passcodeRepository = PasscodeRepositoryImpl(keyValueStorage: userDefaultsStorage)
    }
    
    override func tearDown() {
        try! userDefaultsStorage.deleteValue(forKey: .passcode)
        userDefaultsStorage = nil
        passcodeRepository = nil

        super.tearDown()
    }

    func testHasPasscode() {
        XCTAssert(passcodeRepository.getPasscode() == nil, "Should clear passcode")
        _ = passcodeRepository.save("1234")
        XCTAssertTrue(passcodeRepository.hasPasscode, "Failed to compute hasPasscode")

        _ = passcodeRepository.deletePasscode()
        XCTAssertFalse(passcodeRepository.hasPasscode, "Failed to compute hasPasscode")
    }

    func testGetPasscode() {
        // prepare existing string
        _ = passcodeRepository.save("1234")
        XCTAssertEqual(passcodeRepository.getPasscode(), "1234", "Faield to get passcode")

        _ = passcodeRepository.deletePasscode()
        XCTAssertNil(passcodeRepository.getPasscode(), "Failed to get passcode")
    }

    func testSavePasscode() {
        XCTAssert(passcodeRepository.getPasscode() == nil, "Should clear passcode")
        let isSaved = passcodeRepository.save("1234")

        XCTAssertTrue(isSaved, "Faield to save passcode")
        XCTAssertEqual(passcodeRepository.getPasscode(), "1234", "Faield to save passcode")
        XCTAssertNotNil(passcodeRepository.getPasscode(), "Faield to save passcode")
    }

    func testDeletePasscode() {
        // prepare existing passcode
        _ = passcodeRepository.save("1234")

        let isDeleted = passcodeRepository.deletePasscode()
        XCTAssertTrue(isDeleted, "Faield to delete passcode")
        XCTAssertNil(passcodeRepository.getPasscode(), "Faield to delete passcode")
    }
}
