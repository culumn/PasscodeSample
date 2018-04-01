//
//  PasscodeRepository.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation

protocol PasscodeRepository: class {
    var hasPasscode: Bool { get }
    func getPasscode() -> String?
    func save(_ passcode: String) -> Bool
    func deletePasscode() -> Bool
}
