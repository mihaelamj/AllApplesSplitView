//
//  MainDetailViewController.swift
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

open class MainDetailViewController: AViewController {
  
  // MARK: -
  // MARK: Properties -
  
  private(set) public lazy var mainView: MainDetailView = {
    let v = MainDetailView()
    v.forcedLayer.name = "MainDetailView Layer"
    return v
  }()
  
  // MARK: -
  // MARK: Data Properties -
  
  var item = DataItem.none {
    didSet {
      debugPrint("Changed item: \(item)")
      customizeViewInternal()
    }
  }
  
  
  // MARK: -
  // MARK: View Lifecycle -
  
  open override func loadView() {
    view = mainView
  }
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    // INFO: Need to typecast our view to the appropriate `View` type, which will be resolved at compile time

  }
  
}

// MARK: -
// MARK: Customize Item -

private extension MainDetailViewController {
  
  func customizeViewInternal() {
    if let aView = view as? MainDetailView {
      customizeView(aView)
    }
  }
  
  func customizeView(_ detailView: MainDetailView) {
    detailView.textLayer.string = item.name
    detailView.myColor = item.color
    detailView.name = item.name
  }
  
}
