//
//  KeyValueStorage.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/27.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation

protocol KeyValueStorage: class {
    func getValue<T>(forKey: KeyValueStorageKey) throws -> T?
    func update<T>(_ value: T, forKey: KeyValueStorageKey) throws
    func save<T>(_ value: T, forKey: KeyValueStorageKey) throws
    func deleteValue(forKey: KeyValueStorageKey) throws
}
