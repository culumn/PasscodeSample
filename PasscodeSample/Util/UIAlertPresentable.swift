//
//  UIAlertPresentable.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import UIKit

protocol UIAlertPresentable {
    func presentOKAlert(title: String?,
                        message: String?,
                        animated: Bool,
                        presentCompletion: (() -> Void)?,
                        actionHandler: ((UIAlertAction) -> Void)?)
}

extension UIAlertPresentable where Self: UIViewController {

    func presentOKAlert(title: String?,
                        message: String?,
                        animated: Bool = true,
                        presentCompletion: (() -> Void)? = nil,
                        actionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            guard let completion = actionHandler else { return }
            completion(action)
        }

        alertController.addAction(okAction)
        present(alertController, animated: animated, completion: presentCompletion)
    }
}
