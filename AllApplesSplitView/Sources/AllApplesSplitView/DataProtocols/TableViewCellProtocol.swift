//
//  TableViewCellProtocol.swift
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

// MARK: -
// MARK: DataSource Protocol -

@objc public protocol TableViewCellProtocol: AnyObject {
  func tableCellIdentifierFor(indexPath: IndexPath) -> String?
  func tableCellClassFor(identifier: String) -> CellClassType?
  
  var tableCellIdentifiers:  [String] { get }
  var tableCellClassTypes: [CellClassType] { get }
}


