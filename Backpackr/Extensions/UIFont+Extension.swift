//
//  UIFont+Extension.swift
//  Backpackr
//
//  Created by Sooa Kim on 08/12/2019.
//  Copyright © 2019 Sooa Kim. All rights reserved.
//

import Foundation
import UIKit

extension UIFont{
    /**
        NotoSansKR-Black
        NotoSansKR-Bold
     */
    enum NotoSansWeight: String{
        case black = "Black"
        case bold = "Bold"
    }
    /**
        SFProText-Black
     */
    enum SFProTextWeight: String{
        case black = "Black"
    }
    /**
        AppleSDGothicNeo-ExtraBold
        AppleSDGothicNeo-Bold
        AppleSDGothicNeo-Light
        AppleSDGothicNeo-Medium
        AppleSDGothicNeo-Regular
        AppleSDGothicNeo-SemiBold
        AppleSDGothicNeo-Thin
        AppleSDGothicNeo-UltraLight
     */
    enum SDGothicNeoWeight: String{
        case extraBold = "ExtraBold"
        case bold = "Bold"
        case light = "Light"
        case medium = "Medium"
        case regular = "Regular"
        case semibold = "SemiBold"
        case thin = "Thin"
        case ultraLight = "UltraLight"
    }
    
    static func notoSansFont(ofSize fontSize: CGFloat, weight: NotoSansWeight) -> UIFont{
        return UIFont(name: "NotoSansKR-\(weight.rawValue)", size: fontSize)!
    }
    
    static func sfProtextFont(ofSize fontSize: CGFloat, weight: SFProTextWeight) -> UIFont{
        return UIFont(name: "SFProText-\(weight.rawValue)", size: fontSize)!
    }
    
    static func sdGothicNeoFont(ofSize fontSize: CGFloat, weight: SDGothicNeoWeight = .regular) -> UIFont{
        return UIFont(name: "AppleSDGothicNeo-\(weight.rawValue)", size: fontSize)!
    }
}
