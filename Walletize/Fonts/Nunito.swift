//
//  Nunito.swift
//  Walletize
//
//  Created by Yap Justin on 03/02/24.
//

import Foundation
import SwiftUI

struct Nunito {
    static func regular(size: CGFloat) -> Font {
        return Font.custom("Nunito-Regular", size: size)
    }
    
    static func bold(size: CGFloat) -> Font {
        return Font.custom("Nunito-Bold", size: size)
    }
    
    static func semibold(size: CGFloat) -> Font {
        return Font.custom("Nunito-SemiBold", size: size)
    }
}
