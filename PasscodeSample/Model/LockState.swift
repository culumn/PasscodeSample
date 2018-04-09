//
//  PasscodeState.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation

struct LockState: Equatable {
    var lockType = LockType.registration
    var inputType = PasscodeInputType.new
}

// MARK: - Equatable
extension LockState {

    static func ==(lhs: LockState, rhs: LockState) -> Bool {
        return lhs.lockType == rhs.lockType && lhs.inputType == rhs.inputType
    }
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
