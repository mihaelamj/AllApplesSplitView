//
//  MainTableViewController.swift
//  AllApplesSV_iOS
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

open class MainTableViewController: AViewController {
  
  // MARK: -
  // MARK: Data Properties -
  
  private lazy var data: DataHandler = {
    let ds = DataHandler()
    ds.delegate = self
    return ds
  }()
  
  // MARK: -
  // MARK: UI Properties -
  
  private lazy var tableView: ATableView = {
    let tv = ATableView()
    
    tv.dataSource = data
    tv.delegate = data
    
    #if os(iOS) || os(tvOS)
    tv.rowHeight = 50.0
    tv.sectionHeaderHeight = 50.0
    #endif
    
    #if os(OSX)
    tv.rowHeight = 30.0
    #endif
    
    return tv
  }()
  
  // MARK: -
  // MARK: View Lifecycle -
  
  override public func loadView() {
    self.view = tableView
  }
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    data.registerReusableViews(with: tableView)
    tableView.reloadData()
  }
  
}

// MARK: -
// MARK: Helper -

extension MainTableViewController {
  
  func showItem(_ item: DataItem, detail: MainDetailViewController) {
    detail.item = item
  }
  
  func showFirstItem(detail: MainDetailViewController) {
    guard let firstItem = data.data.items.first else { return }
    showItem(firstItem, detail: detail)
  }

}

// MARK: -
// MARK: Item Delegate -

extension MainTableViewController: ItemDelegate {
  
  func didTapOn(dataSource: Any, item: Any) {
    guard let theItem = item as? DataItem else { return }
    
    self.title = theItem.name
    
    #if os(iOS) || os(tvOS)
    let detailVC = MainDetailViewController()
    detailVC.item = theItem
    let nc = UINavigationController()
    nc.viewControllers = [detailVC]
    self.showDetailViewController(nc, sender: self)
    #endif
    
    #if os(OSX)
    guard let splitVC = parent as? NSSplitViewController else { return }
    guard let detailVC = splitVC.children.last as? MainDetailViewController else { return }
    detailVC.item = theItem
    #endif
    
  }
  
}
