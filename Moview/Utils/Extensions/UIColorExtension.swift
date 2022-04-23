//
//  UIColorExtension.swift
//  Moview
//
//  Created by Luis Alejandro Barbosa Lee on 21/04/22.
//

import UIKit

extension UIColor{
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha:1)
    }
    
    ///Init to get the color from hex
    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = String(hex.prefix(1))
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt:UInt64 = 0x0
        scanner.scanHexInt64(&hexInt)
        
        var r:UInt64!
        var g:UInt64!
        var b:UInt64!
        switch (hexWithoutSymbol.count) {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
        default: break
        }
        
        self.init(
            red: (CGFloat(r)/255),
            green: (CGFloat(g)/255),
            blue: (CGFloat(b)/255),
            alpha:alpha)
    }
    
    struct AppColor {
        static let yellow = UIColor(hex: "F3BF4D")
        static let red = UIColor(hex: "B6291E")
    }
}
