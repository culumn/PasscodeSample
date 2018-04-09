//
//  PasscodeRouterTests.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/04/04.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSample

final class PasscodeRouterTests: XCTestCase {

    var passcodeRouter = PasscodeRouterImpl()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRegister() {
        let expectation = self.expectation(description: "UI async call")
        let homeVC = HomeViewController()
        UIApplication.shared.keyWindow?.rootViewController = homeVC
        passcodeRouter.register(from: homeVC) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            let passcodeVC = homeVC.presentedViewController as? PasscodeViewController
            XCTAssertNotNil(passcodeVC, "Failed to route registration")
            XCTAssertEqual(passcodeVC?.state, LockState(lockType: .registration, inputType: .new))
        }
    }

    func testLogin() {
        let expectation = self.expectation(description: "UI async call")
        let homeVC = HomeViewController()
        UIApplication.shared.keyWindow?.rootViewController = homeVC
        passcodeRouter.login(from: homeVC) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            let passcodeVC = homeVC.presentedViewController as? PasscodeViewController
            XCTAssertNotNil(passcodeVC, "Failed to route registration")
            XCTAssertEqual(passcodeVC?.state, LockState(lockType: .login, inputType: .current))
        }
    }

    func testChange() {
        let expectation = self.expectation(description: "UI async call")
        let homeVC = HomeViewController()
        UIApplication.shared.keyWindow?.rootViewController = homeVC
        passcodeRouter.change(from: homeVC) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            let passcodeVC = homeVC.presentedViewController as? PasscodeViewController
            XCTAssertNotNil(passcodeVC, "Failed to route registration")
            XCTAssertEqual(passcodeVC?.state, LockState(lockType: .change, inputType: .current))
        }
    }

    func testDelete() {
        let expectation = self.expectation(description: "UI async call")
        let homeVC = HomeViewController()
        UIApplication.shared.keyWindow?.rootViewController = homeVC
        passcodeRouter.delete(from: homeVC) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1.0) { error in
            let passcodeVC = homeVC.presentedViewController as? PasscodeViewController
            XCTAssertNotNil(passcodeVC, "Failed to route registration")
            XCTAssertEqual(passcodeVC?.state, LockState(lockType: .delete, inputType: .current))
        }
    }
}
