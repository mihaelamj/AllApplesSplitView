//
//  DataItem+AViewClass.swift
//  AllApplesSV
//
//  Created by Mihaela Mihaljevic Jakic on 24.05.2021..
//

import Foundation
import AllApples

public extension DataItem {
  static func viewClassForItem(named: String) -> ALayerView.Type? {
    
    switch named {
      case "Item 2":
        return CustomDetailView.self
      default:
        return ALayerView.self
    }
  }
  
}
