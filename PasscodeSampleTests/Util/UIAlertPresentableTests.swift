//
//  UIAlertPresentableTests.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/04/07.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSample

final class UIAlertPresentableTests: XCTestCase {

    fileprivate var alertPresentableVC: UIAlertPresentableViewController!
    
    override func setUp() {
        super.setUp()

        alertPresentableVC = UIAlertPresentableViewController()
    }
    
    override func tearDown() {
        alertPresentableVC = nil
        super.tearDown()
    }
    
    func testPresentOKAlert() {
        let expectation = self.expectation(description: "Test")
        UIApplication.shared.keyWindow?.rootViewController = alertPresentableVC
        alertPresentableVC.presentOKAlert(title: "TestTitle",
                                          message: "TestMessage",
                                          animated: false,
                                          presentCompletion: {
                                            expectation.fulfill()
        }) { action in
        }

        waitForExpectations(timeout: 1.0) { error in
            let alertController = self.alertPresentableVC.presentedViewController as? UIAlertController
            XCTAssertNotNil(alertController, "Failed to present alert")
            XCTAssertEqual(alertController?.title, "TestTitle")
            XCTAssertEqual(alertController?.message, "TestMessage")
            XCTAssertEqual(alertController?.preferredStyle, .alert)
            XCTAssertEqual(alertController?.actions.first?.title, "OK")
            XCTAssertEqual(alertController?.actions.first?.style, .default)
        }
    }
}

fileprivate final class UIAlertPresentableViewController: UIViewController, UIAlertPresentable {}
