//
//  HomeViewControllerTests.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/04/07.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSample

final class HomeViewControllerTests: XCTestCase {

    var homeVC: HomeViewController!
    var passcodeRouterMock: PasscodeRouterMock!
    var passcodeRepository: PasscodeRepositoryImpl!
    
    override func setUp() {
        super.setUp()

        let storage = UserDefaultsStorage(domainName: Domain.test.rawValue)
        passcodeRepository = PasscodeRepositoryImpl(keyValueStorage: storage)
        let gateway = PasscodeGatewayImpl(passcodeRepository: passcodeRepository)
        let usecase = PasscodeUseCaseImpl(passcodeGateway: gateway)
        let controller = PasscodeControllerImpl(passcodeUseCase: usecase)

        homeVC = HomeViewController()
        homeVC.controller = controller
        passcodeRouterMock = PasscodeRouterMock()
        homeVC.passcodeRouter = passcodeRouterMock

        UIApplication.shared.keyWindow?.rootViewController = homeVC
    }
    
    override func tearDown() {
        _ = passcodeRepository.deletePasscode()
        homeVC = nil
        passcodeRouterMock = nil
        passcodeRepository = nil
        UIApplication.shared.keyWindow?.rootViewController = nil
        super.tearDown()
    }

    func testApplicationWillEnterForeground() {
        homeVC.viewDidLoad()
        NotificationCenter.default.post(Notification(name: .UIApplicationWillEnterForeground))

        XCTAssertFalse(passcodeRouterMock.didCallLogin)
    }

    func testApplicationWillEnterForegroundWithPasscode() {
        homeVC.viewDidLoad()
        _ = passcodeRepository.save("1234")
        NotificationCenter.default.post(Notification(name: .UIApplicationWillEnterForeground))

        XCTAssertTrue(passcodeRouterMock.didCallLogin)
    }

    func testDidTapRegisterButton() {
        let registerButton = UIButton()
        homeVC.didTapRegisterButton(registerButton)

        XCTAssertTrue(passcodeRouterMock.didCallRegister)
    }

    func testDidTapRegisterButtonWithPasscode() {
        _ = passcodeRepository.save("1234")
        let registerButton = UIButton()
        homeVC.didTapRegisterButton(registerButton)

        XCTAssertFalse(passcodeRouterMock.didCallRegister)
    }

    func testDidTapLoginButton() {
        let loginButton = UIButton()
        homeVC.didTapLoginButton(loginButton)

        XCTAssertFalse(passcodeRouterMock.didCallLogin)
    }

    func testDidTapLoginButtonWithPasscode() {
        _ = passcodeRepository.save("1234")
        let loginButton = UIButton()
        homeVC.didTapLoginButton(loginButton)

        XCTAssertTrue(passcodeRouterMock.didCallLogin)
    }

    func testDidTapchangeButton() {
        let changeButton = UIButton()
        homeVC.didTapChangeButton(changeButton)

        XCTAssertFalse(passcodeRouterMock.didCallChange)
    }

    func testDidTapchangeButtonWithPasscode() {
        _ = passcodeRepository.save("1234")
        let changeButton = UIButton()
        homeVC.didTapChangeButton(changeButton)

        XCTAssertTrue(passcodeRouterMock.didCallChange)
    }

    func testDidTapDeleteButton() {
        let deleteButton = UIButton()
        homeVC.didTapDeleteButton(deleteButton)

        XCTAssertFalse(passcodeRouterMock.didCallDelete)
    }

    func testDidTapDeleteButtonWithPasscode() {
        _ = passcodeRepository.save("1234")
        let deleteButton = UIButton()
        homeVC.didTapDeleteButton(deleteButton)

        XCTAssertTrue(passcodeRouterMock.didCallDelete)
    }
}
