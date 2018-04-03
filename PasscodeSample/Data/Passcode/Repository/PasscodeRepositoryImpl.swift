//
//  PasscodeRepositoryImpl.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation

final class PasscodeRepositoryImpl {

    let userDefaultsStorage: UserDefaultsStorage

    init(userDefaultsStorage: UserDefaultsStorage) {
        self.userDefaultsStorage = userDefaultsStorage
    }
}

// MARK: - PasscodeRepository
extension PasscodeRepositoryImpl: PasscodeRepository {

    var hasPasscode: Bool {
        return getPasscode() != nil
    }

    func getPasscode() -> String? {
        do {
            return try userDefaultsStorage.getValue(forKey: .passcode)
        } catch {
            return nil
        }
    }

    func save(_ passcode: String) -> Bool {
        do {
            try userDefaultsStorage.save(passcode, forKey: .passcode)
            return true
        } catch {
            return false
        }
    }

    func deletePasscode() -> Bool {
        do {
            try userDefaultsStorage.deleteValue(forKey: .passcode)
            return true
        } catch {
            return false
        }
    }
}
