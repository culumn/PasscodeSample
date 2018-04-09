//
//  PasscodeRouterMock.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/04/07.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import UIKit
@testable import PasscodeSample

final class PasscodeRouterMock: PasscodeRouter {
    var didCallRegister = false
    var didCallLogin = false
    var didCallChange = false
    var didCallDelete = false

    func register(from sourceVC: UIViewController, presentCompletion: (() -> Void)?) {
        didCallRegister = true
    }

    func login(from sourceVC: UIViewController, presentCompletion: (() -> Void)?) {
        didCallLogin = true
    }

    func change(from sourceVC: UIViewController, presentCompletion: (() -> Void)?) {
        didCallChange = true
    }

    func delete(from sourceVC: UIViewController, presentCompletion: (() -> Void)?) {
        didCallDelete = true
    }
}
