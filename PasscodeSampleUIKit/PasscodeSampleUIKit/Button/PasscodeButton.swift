//
//  PasscodeButton.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import UIKit

@IBDesignable final public class PasscodeButton: UIButton {

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

    @IBInspectable open var color: UIColor? {
        didSet {
            backgroundColor = color
        }
    }

    @IBInspectable open var image: UIImage? {
        didSet {
            setImage(image, for: .normal)
            imageView?.contentMode = .scaleAspectFit
        }
    }

    @IBInspectable open var visible: Bool = true {
        didSet {
            alpha = visible ? 1.0 : 0.0
            isEnabled = visible
        }
    }

    @IBInspectable open var pressedColor: UIColor?

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        layer.masksToBounds = true
        layer.cornerRadius = min(rect.width, rect.height) / 2
    }

    override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        guard let _ = color,
            let pressedColor = pressedColor else { return super.beginTracking(touch, with: event) }
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = pressedColor
        }

        return super.beginTracking(touch, with: event)
    }

    override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let color = color,
            let _ = pressedColor else { return super.endTracking(touch, with: event) }
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = color
        }

        return super.endTracking(touch, with: event)
    }
}
