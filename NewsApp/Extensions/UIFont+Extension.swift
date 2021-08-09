//
//  UIFont+Extension.swift
//  e-Mawaeed
//
//  Created by Abdelrhman Eliwa on 07/06/2021.
//

import UIKit

extension UIFont {
    enum SFProText: String {
        case black = "Black"
        case blackItalic = "BlackItalic"
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        case heavy = "Heavy"
        case heavyItalic = "HeavyItalic"
        case light = "Light"
        case lightItalic = "LightItalic"
        case medium = "Medium"
        case mediumItalic = "MediumItalic"
        case regular = "Regular"
        case regularItalic = "RegularItalic"
        case semiBold = "SemiBold"
        case semiBoldItalic = "SemiBoldItalic"
        case thin = "Thin"
        case thinItalic = "ThinItalic"
        case ultralight = "Ultralight"
        case ultralightItalic = "UltralightItalic"
    }
    
    static func sfProText(_ type: SFProText = .regular, ofSize size: CGFloat = 12) -> UIFont {
        return UIFont(name: "SFProText-\(type.rawValue)", size: size)!
    }
}
