//
//  PasscodeGatewayImpl.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation

final class PasscodeGatewayImpl {

    let passcodeRepository: PasscodeRepository

    weak var delegate: PasscodeGatewayDelegate?

    init(passcodeRepository: PasscodeRepository) {
        self.passcodeRepository = passcodeRepository
    }
}

// MARK: - PasscodeGateway
extension PasscodeGatewayImpl: PasscodeGateway {

    var hasPasscode: Bool {
        return passcodeRepository.hasPasscode
    }

    func getPasscode() -> String? {
        return passcodeRepository.getPasscode()
    }

    func save(_ passcode: String) {
        guard passcodeRepository.save(passcode) else {
            delegate?.didNotSavePasscode()
            return
        }
        delegate?.didSavePasscode()
    }

    func deletePasscode() {
        guard passcodeRepository.deletePasscode() else {
            delegate?.didNotDeletePasscode()
            return
        }
        delegate?.didDeletePasscode()
    }
}
