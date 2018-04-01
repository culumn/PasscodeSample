//
//  KeyValueStorageError.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/27.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation

enum KeyValueStorageError: Error {
    case get
    case update
    case save
    case delete
}
