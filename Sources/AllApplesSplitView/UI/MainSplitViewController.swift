//
//  MainSplitViewController.swift
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

open class MainSplitViewController: ASplitViewController {
  
  // MARK: -
  // MARK: Properties -
  
  lazy var masterVC = MainTableViewController()
  lazy var detailVC = MainDetailViewController()
  
  // MARK: -
  // MARK: Init -
  
  #if os(OSX)
  override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setupMacOS()
  }
  
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
    setupMacOS()
  }
  #endif
  
  // MARK: -
  // MARK: View Lifecycle -
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    #if os(iOS) || os(tvOS)
    setupIos()
    #endif
//    masterVC.showFirstItem(detail: detailVC)
  }
  
}


// MARK: -
// MARK: Platform Setup -

private extension MainSplitViewController {
  func setupIos() {
    #if os(iOS) || os(tvOS)
    self.delegate = self
    let masterNav = UINavigationController()
    let detailNav = UINavigationController()
    masterNav.viewControllers = [masterVC]
    detailNav.viewControllers = [detailVC]
    self.viewControllers = [masterNav, detailNav]
    
    // INFO: The Table view is always visible, if possible
    preferredDisplayMode = UISplitViewController.DisplayMode.oneBesideSecondary
    #endif
  }
  
  func setupMacOS() {
    #if os(OSX)

    splitView.dividerStyle = .paneSplitter
    
    let splitViewResorationIdentifier = "com.aleahim.restorationId:mainSplitViewController"
    splitView.autosaveName = NSSplitView.AutosaveName(splitViewResorationIdentifier)
    splitView.identifier = NSUserInterfaceItemIdentifier(rawValue: splitViewResorationIdentifier)
    
    masterVC.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 180).isActive = true
    detailVC.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
    
    let sidebarItem = NSSplitViewItem(viewController: masterVC)
    sidebarItem.canCollapse = true
    sidebarItem.holdingPriority = NSLayoutConstraint.Priority(NSLayoutConstraint.Priority.defaultLow.rawValue + 1)
    addSplitViewItem(sidebarItem)
    
    let xibItem = NSSplitViewItem(viewController: detailVC)
    addSplitViewItem(xibItem)
    #endif
  }
}

#if os(iOS) || os(tvOS)
extension MainSplitViewController: UISplitViewControllerDelegate {
  
  func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
    if let nc = secondaryViewController as? UINavigationController {
      if let topVc = nc.topViewController {
        if let dc = topVc as? MainDetailViewController {
          let hasDetail = DataItem.none !== dc.item
          return !hasDetail
        }
      }
    }
    return true
  }
}
#endif
