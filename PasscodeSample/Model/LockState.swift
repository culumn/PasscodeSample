//
//  PasscodeState.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation

struct LockState {
    var lockType = LockType.registration
    var inputType = PasscodeInputType.new
}

enum LockType {
    case registration
    case login
    case change
    case delete
}

enum PasscodeInputType {
    case current
    case new
    case confirmation
}
