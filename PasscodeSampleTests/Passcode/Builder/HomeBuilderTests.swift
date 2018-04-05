//
//  HomeBuilderTests.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/04/04.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSample

class HomeBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let passcodeVC = HomeBuilder.build() as? HomeViewController
        let passcodeController = passcodeVC?.controller as? PasscodeControllerImpl
        let passcodeUseCase = passcodeController?.passcodeUseCase as? PasscodeUseCaseImpl
        let passcodePresenter = passcodeUseCase?.delegate as? PasscodePresenterImpl
        let passcodeGateway = passcodeUseCase?.passcodeGateway as? PasscodeGatewayImpl
        let passcodeRepository = passcodeGateway?.passcodeRepository as? PasscodeRepositoryImpl
        let userdefaultsStorage = passcodeRepository?.keyValueStorage as? UserDefaultsStorage

        XCTAssertNotNil(passcodeVC, "Failed to build home module")
        XCTAssertNotNil(passcodeController, "Failed to build home module")
        XCTAssertNotNil(passcodeUseCase, "Failed to build home module")
        XCTAssertNil(passcodePresenter, "Failed to build home module")
        XCTAssertNotNil(passcodeGateway, "Failed to build home module")
        XCTAssertNotNil(passcodeRepository, "Failed to build home module")
        XCTAssertNotNil(userdefaultsStorage, "Failed to build home module")

        XCTAssertNil(passcodeGateway?.delegate as? PasscodeUseCaseImpl, "Failed to build home module")
        XCTAssertNil(passcodePresenter?.delegate as? PasscodeViewController, "Failed to build home module")
    }
}
