//
//  UnderlineTextButton.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import UIKit

@IBDesignable final class UnderlineTextButton: UIButton {

    @IBInspectable var title: String? {
        didSet {
            setTitle(title, for: .normal)
        }
    }

    override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)

        let attributedText = NSAttributedString(string: title ?? "", attributes: [.underlineStyle:  NSUnderlineStyle.styleSingle.rawValue])
        titleLabel?.attributedText = attributedText
    }
}
