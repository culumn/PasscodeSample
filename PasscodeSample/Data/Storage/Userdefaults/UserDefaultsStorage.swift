//
//  UserDefaultsStorageImpl.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation

final class UserDefaultsStorage {
    var userDefaults = UserDefaults.standard

    init(domainName: String) {
        guard let userDefaults = UserDefaults(suiteName: domainName) else {
            self.userDefaults.addSuite(named: domainName)
            return
        }

        self.userDefaults = userDefaults
    }
}

// MARK: - KeyValueStorage
extension UserDefaultsStorage: KeyValueStorage {

    func getValue<T>(forKey: KeyValueStorageKey) throws -> T? {
        return userDefaults.value(forKey: forKey.rawValue) as? T
    }

    func update<T>(_ value: T, forKey: KeyValueStorageKey) throws {
        userDefaults.set(value, forKey: forKey.rawValue)
        guard userDefaults.synchronize() else { throw KeyValueStorageError.update }
    }

    func save<T>(_ value: T, forKey: KeyValueStorageKey) throws {
        userDefaults.set(value, forKey: forKey.rawValue)
        guard userDefaults.synchronize() else { throw KeyValueStorageError.save }
    }

    func deleteValue(forKey: KeyValueStorageKey) throws {
        userDefaults.removeObject(forKey: forKey.rawValue)
        guard userDefaults.synchronize() else { throw KeyValueStorageError.update }
    }
}
