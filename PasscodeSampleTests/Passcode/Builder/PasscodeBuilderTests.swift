//
//  PasscodeBuilderTests.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/04/04.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSample

final class PasscodeBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testBuild() {
        let passcodeVC = PassscodeBuilder.build() as? PasscodeViewController
        let passcodeController = passcodeVC?.controller as? PasscodeControllerImpl
        let passcodeUseCase = passcodeController?.passcodeUseCase as? PasscodeUseCaseImpl
        let passcodePresenter = passcodeUseCase?.delegate as? PasscodePresenterImpl
        let passcodeGateway = passcodeUseCase?.passcodeGateway as? PasscodeGatewayImpl
        let passcodeRepository = passcodeGateway?.passcodeRepository as? PasscodeRepositoryImpl
        let userdefaultsStorage = passcodeRepository?.keyValueStorage as? UserDefaultsStorage

        XCTAssertNotNil(passcodeVC, "Failed to build passcode module")
        XCTAssertNotNil(passcodeController, "Failed to build passcode module")
        XCTAssertNotNil(passcodeUseCase, "Failed to build passcode module")
        XCTAssertNotNil(passcodePresenter, "Failed to build passcode module")
        XCTAssertNotNil(passcodeGateway, "Failed to build passcode module")
        XCTAssertNotNil(passcodeRepository, "Failed to build passcode module")
        XCTAssertNotNil(userdefaultsStorage, "Failed to build passcode module")

        XCTAssertNotNil(passcodeGateway?.delegate as? PasscodeUseCaseImpl, "Failed to build passcode module")
        XCTAssertNotNil(passcodePresenter?.delegate as? PasscodeViewController, "Failed to build passcode module")
    }
}
