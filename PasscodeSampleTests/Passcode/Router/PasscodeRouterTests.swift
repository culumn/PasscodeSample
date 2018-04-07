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
        let homeVC = HomeViewController()
        passcodeRouter.register(from: homeVC) {
            let passcodeVC = homeVC.presentedViewController as? PasscodeViewController
            XCTAssertNotNil(passcodeVC, "Failed to route registration")
            XCTAssertEqual(passcodeVC!.state, LockState(lockType: .registration, inputType: .new))
        }
    }

    func testLogin() {
        let homeVC = HomeViewController()
        passcodeRouter.login(from: homeVC) {
            let passcodeVC = homeVC.presentedViewController as? PasscodeViewController
            XCTAssertNotNil(passcodeVC, "Failed to route registration")
            XCTAssertEqual(passcodeVC!.state, LockState(lockType: .login, inputType: .current))
        }
    }

    func testChange() {
        let homeVC = HomeViewController()
        passcodeRouter.change(from: homeVC) {
            let passcodeVC = homeVC.presentedViewController as? PasscodeViewController
            XCTAssertNotNil(passcodeVC, "Failed to route registration")
            XCTAssertEqual(passcodeVC!.state, LockState(lockType: .change, inputType: .current))
        }
    }

    func testDelete() {
        let homeVC = HomeViewController()
        passcodeRouter.delete(from: homeVC) {
            let passcodeVC = homeVC.presentedViewController as? PasscodeViewController
            XCTAssertNotNil(passcodeVC, "Failed to route registration")
            XCTAssertEqual(passcodeVC!.state, LockState(lockType: .delete, inputType: .current))
        }
    }
}
