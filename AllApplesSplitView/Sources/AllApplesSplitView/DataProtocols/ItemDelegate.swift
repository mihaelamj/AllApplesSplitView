//
//  ItemDelegate.swift
//  AllApplesSV
//
//  Created by Mihaela Mihaljevic Jakic on 07.05.2021..
//

import Foundation

// MARK: -
// MARK: Delegate Protocol -

protocol ItemDelegate: AnyObject {
  func didTapOn(dataSource: Any, item: Any)
}
