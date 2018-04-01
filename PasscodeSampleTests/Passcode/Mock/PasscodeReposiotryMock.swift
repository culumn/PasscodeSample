//
//  PasscodeReposiotryMock.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
@testable import PasscodeSample

final class PasscodeRepositoryMock {

    let userDefaultsStorage: UserDefaultsStorage

    private var isSaved: Bool?
    private var isDeleted: Bool?

    var didReferHasPasscode = false
    var didCallGetPasscode = false

    init(userDefaultsStorage: UserDefaultsStorage) {
        self.userDefaultsStorage = userDefaultsStorage
    }

    func set(isSaved: Bool) {
        self.isSaved = isSaved
    }

    func set(isDeleted: Bool) {
        self.isDeleted = isDeleted
    }
}

// MARK: - PasscodeRepository
extension PasscodeRepositoryMock: PasscodeRepository {

    var hasPasscode: Bool {
        didReferHasPasscode = true
        return try! userDefaultsStorage.getValue(forKey: .passcode) != nil
    }

    func getPasscode() -> String? {
        didCallGetPasscode = true
        return try! userDefaultsStorage.getValue(forKey: .passcode)
    }

    func save(_ passcode: String) -> Bool {
        guard isSaved == nil else { return isSaved! }
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
