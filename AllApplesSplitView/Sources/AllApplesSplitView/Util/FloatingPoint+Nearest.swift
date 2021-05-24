//
//  FloatingPoint+Nearest.swift
//  AllApplesSV
//
//  Created by Mihaela Mihaljevic Jakic on 24.05.2021..
//

import Foundation

public extension FloatingPoint {
  func rounded(to value: Self, roundingRule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Self {
    (self / value).rounded(roundingRule) * value
  }
}


//let value = 325.0
//value.rounded(to: 10) // 330 (default rounding mode toNearestOrAwayFromZero)
//value.rounded(to: 10, roundingRule: .down) // 320
