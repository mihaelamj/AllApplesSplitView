//
//  Collection+Safe.swift
//  AllApplesSV_iOS
//
//  Created by Mihaela Mihaljevic Jakic on 07.05.2021..
//

import Foundation

public extension Collection {
  // INFO: -  Returns the element at the specified index if it is within bounds, otherwise nil.
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

extension Collection {
  // INFO: Usage -
  static func testMeee() {
    let array = [1, 2, 3]
    for index in -20 ... 20 {
      if let item = array[safe: index] {
        print(item)
      }
    }
  }
}
