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
}
