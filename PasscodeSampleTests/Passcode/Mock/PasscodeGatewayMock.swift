//
//  PasscodeGatewayMock.swift
//  PasscodeSampleTests
//
//  Created by Matsuoka Yoshiteru on 2018/03/25.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
@testable import PasscodeSample

final class PasscodeGatewayMock {

    let passcodeRepository: PasscodeRepository

    var didReferHasPasscode = false
    var didCallGetPasscode = false
    var didCallSavePasscode = false
    var didCallDeletePasscode = false

    weak var delegate: PasscodeGatewayDelegate?


    init(passcodeRepository: PasscodeRepository) {
        self.passcodeRepository = passcodeRepository
    }
}

extension PasscodeGatewayMock: PasscodeGateway {

    var hasPasscode: Bool {
        didReferHasPasscode = true
        return passcodeRepository.hasPasscode
    }

    func getPasscode() -> String? {
        didCallGetPasscode = true
        return passcodeRepository.getPasscode()
    }

    func save(_ passcode: String) {
        didCallSavePasscode = true
        guard passcodeRepository.save(passcode) else {
            delegate?.didNotSavePasscode()
            return
        }
        delegate?.didSavePasscode()
    }

    func deletePasscode() {
        didCallDeletePasscode = true
        guard passcodeRepository.deletePasscode() else {
            delegate?.didNotDeletePasscode()
            return
        }
        delegate?.didDeletePasscode()
    }
}
