//
//  DataItem.swift
//  AllApplesSV
//
//  Created by Mihaela Mihaljevic Jakic on 07.05.2021..
//

import Foundation
import AllApples

#if os(iOS) || os(tvOS)
import UIKit
#endif

#if os(OSX)
import Cocoa
#endif

open class DataItem {
  
  // MARK: -
  // MARK: Data Properties -
  
  var name: String
  var isChecked: Bool
  var color: AColor
  
  class var none: DataItem {
    return DataItem(name: "none", isChecked: false, color: AColor.systemGray)
  }
  
  class var some: [DataItem] {
    return [
      DataItem(name: "Item 1", isChecked: false, color: AColor.systemBlue),
      DataItem(name: "Item 2", isChecked: true, color: AColor.systemPink),
      DataItem(name: "Item 3", isChecked: false, color: AColor.systemGreen),
      DataItem(name: "Item 4", isChecked: true, color: AColor.systemRed),
      DataItem(name: "Item 5", isChecked: false, color: AColor.systemOrange)
    ]
  }
  
  // MARK: -
  // MARK: Init -
  
  internal init(name: String, isChecked: Bool, color: AColor) {
    self.name = name
    self.isChecked = isChecked
    self.color = color
  }
}

// MARK: -
// MARK: Description -

extension DataItem: CustomStringConvertible {
  public var description: String {
    let checked = isChecked ? " ✅" : ""
    return "\(name)\(checked)"
  }
}

