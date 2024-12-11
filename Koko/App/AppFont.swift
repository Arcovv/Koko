//
//  AppFont.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import UIKit

enum AppFont {
    enum FontWeight: String {
        case regular = "Regular"
        case thin = "Thin"
        case medium = "Medium"
        case semibold = "Semibold"
        case light = "Light"
        case ultralight = "Ultralight"
    }
    
    static func pingFangTC(size: CGFloat, weight: FontWeight = .regular) -> UIFont {
        return UIFont(name: "PingFangTC-\(weight.rawValue)", size: size)!
    }
}
