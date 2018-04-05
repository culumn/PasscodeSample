//
//  PasscodeBuilder.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import UIKit

struct PassscodeBuilder: Buildable {

    private init() {}

    static func build() -> UIViewController {
        let storage = UserDefaultsStorage(domainName: Domain.app.rawValue)
        let repository = PasscodeRepositoryImpl(keyValueStorage: storage)
        let gateway = PasscodeGatewayImpl(passcodeRepository: repository)
        let usecase = PasscodeUseCaseImpl(passcodeGateway: gateway)
        let controller = PasscodeControllerImpl(passcodeUseCase: usecase)
        let presenter = PasscodePresenterImpl()

        let stroyBoard = UIStoryboard(name: "Passcode", bundle: nil)
        guard let passcodeVC = stroyBoard.instantiateInitialViewController() as? PasscodeViewController else {
            preconditionFailure("Failed to load PasscodeViewController from Passcode.storyboard")
        }

        gateway.delegate = usecase
        usecase.delegate = presenter
        presenter.delegate = passcodeVC
        passcodeVC.controller = controller

        return passcodeVC
    }
}
