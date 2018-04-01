//
//  PasscodeGatewayDelegate.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation

protocol PasscodeGatewayDelegate: class {
    func didSavePasscode()
    func didNotSavePasscode()
    func didDeletePasscode()
    func didNotDeletePasscode()
}
