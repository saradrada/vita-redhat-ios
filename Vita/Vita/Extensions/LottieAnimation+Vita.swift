//
//  LottieAnimation+Vita.swift
//  Vita
//
//  Created by Sara Ortiz Drada on 15.10.24.
//

import Foundation
import Lottie

public extension LottieAnimation {
    static func launch() -> LottieAnimation? {
        guard let filepath = Bundle.main.path(forResource: "launch", ofType: "json") else {
            return nil
        }
        return LottieAnimation.filepath(filepath)
    }
}
