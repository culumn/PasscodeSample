//
//  UnderlineTextButton.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import UIKit

@IBDesignable final public class UnderlineTextButton: UIButton {

    @IBInspectable open var underlineText: String? {
        didSet {
            setTitle(underlineText, for: .normal)
        }
    }

    override public func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle(title, for: state)

        guard let title = title else { return }
        let attributedText = NSAttributedString(string: title,
                                                attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        titleLabel?.attributedText = attributedText
    }
}
