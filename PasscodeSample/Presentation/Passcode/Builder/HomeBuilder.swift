//
//  HomeBuilder.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import UIKit

struct HomeBuilder: Buildable {

    private init() {}

    static func build() -> UIViewController {
        let storage = UserDefaultsStorage(domainName: Domain.app.rawValue)
        let repository = PasscodeRepositoryImpl(keyValueStorage: storage)
        let gateway = PasscodeGatewayImpl(passcodeRepository: repository)
        let usecase = PasscodeUseCaseImpl(passcodeGateway: gateway)
        let controller = PasscodeControllerImpl(passcodeUseCase: usecase)

        let stroyBoard = UIStoryboard(name: "Home", bundle: nil)
        guard let homeVC = stroyBoard.instantiateInitialViewController() as? HomeViewController else {
            preconditionFailure("Failed to load HomeViewController from Home.storyboard")
        }

        homeVC.controller = controller
        homeVC.passcodeRouter = PasscodeRouterImpl()

        return homeVC
    }
}
