//
//  Buildable.swift
//  PasscodeSample
//
//  Created by Matsuoka Yoshiteru on 2018/03/24.
//  Copyright © 2018年 com.github.culumn. All rights reserved.
//

import Foundation
import UIKit

protocol Buildable {
    static func build() -> UIViewController
}
