//
//  PasscodePlaceholderView.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import UIKit

@IBDesignable final public class PasscodePlaceholderView: UIView {

    @IBInspectable open var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable open var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable open var filledColor: UIColor?
    @IBInspectable open var emptyColor: UIColor?
    @IBInspectable open var errorColor: UIColor?

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        layer.masksToBounds = true
        layer.cornerRadius = min(rect.width, rect.height) / 2
    }

    public func fillColor(completion: ((Bool) -> Void)? = nil) {
        guard let filledColor = filledColor else {
            completion?(false)
            return
        }

        UIView.animate(withDuration: 0.5,
                       animations: {
                        self.backgroundColor = filledColor
        }, completion: completion)
    }

    public func fillEmpty(completion: ((Bool) -> Void)? = nil) {
        guard let emptyColor = emptyColor else {
            completion?(false)
            return
        }


        UIView.animate(withDuration: 0.5,
                       animations: {
                        self.backgroundColor = emptyColor
        }, completion: completion)
    }

    public func fillErrorColor(completion: ((Bool) -> Void)? = nil) {
        guard let errorColor = errorColor else {
            completion?(false)
            return
        }


        UIView.animate(withDuration: 0.5,
                       animations: {
                        self.backgroundColor = errorColor
        }, completion: completion)
    }
}
