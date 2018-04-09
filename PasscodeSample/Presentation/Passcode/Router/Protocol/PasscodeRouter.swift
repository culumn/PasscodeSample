//
//  PasscodeRouter.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/04/07.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import UIKit

protocol PasscodeRouter: class {
    func register(from sourceVC: UIViewController, presentCompletion: (() -> Void)?)
    func login(from sourceVC: UIViewController, presentCompletion: (() -> Void)?)
    func change(from sourceVC: UIViewController, presentCompletion: (() -> Void)?)
    func delete(from sourceVC: UIViewController, presentCompletion: (() -> Void)?)
}
