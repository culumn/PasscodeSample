//
//  PasscodePlaceholderView.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import UIKit

@IBDesignable final class PasscodePlaceholderView: UIView {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var filledColor: UIColor?
    @IBInspectable var emptyColor: UIColor?
    @IBInspectable var errorColor: UIColor?

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        layer.masksToBounds = true
        layer.cornerRadius = min(rect.width, rect.height) / 2
    }

    func fillColor() {
        guard let filledColor = filledColor else { return }
        UIView.animate(withDuration: 0.5) {
            self.backgroundColor = filledColor
        }
    }

    func fillEmpty() {
        guard let emptyColor = emptyColor else { return }
        UIView.animate(withDuration: 0.5) {
            self.backgroundColor = emptyColor
        }
    }

    func fillErrorColor() {
        guard let errorColor = errorColor else { return }
        UIView.animate(withDuration: 0.5) {
            self.backgroundColor = errorColor
        }
    }
}
