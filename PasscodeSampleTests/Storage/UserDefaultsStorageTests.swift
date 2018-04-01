//
//  UserDefaultsStorageTests.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import XCTest
@testable import PasscodeSample

final class UserDefaultsStorageTests: XCTestCase {

    var userDefaultsStorage: UserDefaultsStorage!
    
    override func setUp() {
        super.setUp()

        userDefaultsStorage = UserDefaultsStorage(domainName: Domain.test.rawValue)
    }
    
    override func tearDown() {
        try! userDefaultsStorage.deleteValue(forKey: .passcode)
        userDefaultsStorage = nil
        super.tearDown()
    }

    func testSaveValue() {
        try! userDefaultsStorage.save("TestString", forKey: .passcode)

        XCTAssertNotNil(try! userDefaultsStorage.getValue(forKey: .passcode), "Failed to save value")
    }

    func testGetValue() {
        // prepare existing value
        try! userDefaultsStorage.save("TestString", forKey: .passcode)
        XCTAssertEqual(try! userDefaultsStorage.getValue(forKey: .passcode), "TestString", "Failed to get value")

        // delete value
        try! userDefaultsStorage.deleteValue(forKey: .passcode)
        XCTAssertNil(try! userDefaultsStorage.getValue(forKey: .passcode), "Failed to get value")
    }

    func testDeleteValue() {
        // prepare existing string
        try! userDefaultsStorage.save("TestString", forKey: .passcode)

        try! userDefaultsStorage.deleteValue(forKey: .passcode)
        XCTAssertNil(try! userDefaultsStorage.getValue(forKey: .passcode), "Failed to delete value")
    }

    func testUpdateValue() {
        // prepare existing string
        try! userDefaultsStorage.save("TestString", forKey: .passcode)

        try! userDefaultsStorage.update("NewTestString", forKey: .passcode)
        XCTAssertEqual(try! userDefaultsStorage.getValue(forKey: .passcode), "NewTestString", "Failed to update value")
    }
}
