//
//  DefaultTableViewCellProtocolHandler.swift
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
// MARK: Handler Class -

public class DataHandler: NSObject {
  
  weak var tableCellHandler: TableViewCellProtocol?
  weak var sectionHandler: SectionedDataSource?
  weak var delegate: ItemDelegate?
  
  let data = DataImplementation()
  
  #if os(iOS) || os(tvOS)
  let defaultTextColor = AColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1) // #424242
  #endif
  
  #if os(OSX)
  let defaultTextColor = AColor.white
  #endif
  
  
  // MARK: -
  // MARK: init -
  
  override public init() {
    tableCellHandler = data
    sectionHandler = data
  }
}

// MARK: -
// MARK: Register Reusable Views

public extension DataHandler {
  
  func registerReusableViews(with tableView: ATableView) {
    #if os(iOS) || os(tvOS)
    tableCellHandler?.tableCellIdentifiers.forEach { cellIdent in
      let cellClass = tableCellHandler?.tableCellClassFor(identifier: cellIdent)
      tableView.register(cellClass, forCellReuseIdentifier: cellIdent)
    }
    #endif
    
    #if os(OSX)
    tableCellHandler?.tableCellIdentifiers.forEach { cellIdent in
      let ident = NSUserInterfaceItemIdentifier(rawValue: cellIdent)
      tableView.addTableColumn(NSTableColumn(identifier: ident))
    }
    #endif
  }
  
  #if os(OSX)
  internal func identifierFor(column: Int) -> String? {
    let indexPath = IndexPath(item: 0, section: column)
    return tableCellHandler?.tableCellIdentifierFor(indexPath: indexPath)
  }
  #endif
}

// MARK: -
// MARK: ATableViewDataSource -

extension DataHandler: ATableViewDataSource {
  
  #if os(iOS) || os(tvOS)
  public func numberOfSections(in tableView: UITableView) -> Int {
    return sectionHandler?.numberOfSections() ?? 0
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sectionHandler?.numberOfItemsInSection(section) ?? 0
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let sectionHandler = sectionHandler else { preconditionFailure("Error, no item handler") }
    
    guard let cellIdentifier = tableCellHandler?.tableCellIdentifierFor(indexPath: indexPath) else {
      preconditionFailure("Error, no Cell identifier for item in section: \(indexPath.section), row: \(indexPath.row)!")
    }
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    cell.selectionStyle = .none
    
    cell.textLabel?.text = sectionHandler.itemTitleAt(indexPath)
    
    // styling
    cell.textLabel?.font = .systemFont(ofSize: 16)
    cell.textLabel?.textColor = defaultTextColor // #424242
    
    cell.accessoryType = sectionHandler.itemIsCheckedAt(indexPath) ? .checkmark : .none
    
    return cell
  }
  #endif
  
  #if os(OSX)
  public func numberOfRows(in tableView: NSTableView) -> Int {
    return sectionHandler?.numberOfItemsInSection(0) ?? 0
  }
  #endif
  
}

// MARK: -
// MARK: ATableViewDelegate -

extension DataHandler: ATableViewDelegate {
  
  #if os(iOS) || os(tvOS)
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let item = sectionHandler?.itemAt(indexPath) else {
      preconditionFailure("Error, no item in section: \(indexPath.section), row: \(indexPath.row)!")
    }
    delegate?.didTapOn(dataSource: self, item: item)
  }
  
  //INFO: This is how we get rid of the last tableViewCell separator -
  public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView()
  }
  #endif
  
  
  #if os(OSX)
  public func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    
    guard let column = tableColumn else { preconditionFailure("Error, table colimn is nil!") }
    
    guard let itemHandler = sectionHandler else { preconditionFailure("Error, no item handler") }
    
    // fetch Column Index & identifier
    guard let columnIndex = fetchIndexOfColumnIn(tableView, tableColumn: column) else {
      preconditionFailure("Error, column: \(column), is not among table columns!")
    }
    guard let cellIdenifier = identifierFor(column: columnIndex) else {
      preconditionFailure("Error, no Cell identifier for item in column in index: \(columnIndex)!")
    }
    
    var cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdenifier), owner: self) as? NSTextField
    if cell == nil { cell = makeTextField(tableView) }
    
    if let cell = cell {
      cell.identifier = NSUserInterfaceItemIdentifier(rawValue: cellIdenifier)
      
      let cellText = itemHandler.sectionlessItemTitleAt(row); let cellTextChecked = "\(cellText)✅"
      let firstColumnText = itemHandler.sectionlessItemIsCheckedAt(row) ? cellTextChecked : cellText
      
      let secondColumnText = itemHandler.sectionlessItemIsCheckedAt(row) ? "Finished" : "NOT Finished"
      
      cell.stringValue = columnIndex == 0 ? firstColumnText : secondColumnText
      cell.textColor = defaultTextColor
      cell.backgroundColor = .clear
      
      cell.isBezeled = false
      cell.isEditable = false
    }
    return cell
  }
  
  public func tableView(_ tableView: NSTableView,  heightOfRow row: Int) -> CGFloat  {
    return 190.0
  }
  
  public func tableViewSelectionDidChange(_ notification: Notification) {
    guard let theTableView = notification.object as? NSTableView else { return }
    let indexes = theTableView.selectedRowIndexes
    if let index = indexes.first {
      if let item = sectionHandler?.sectionlessItemAt(index) {
        delegate?.didTapOn(dataSource: self, item: item)
      }
    }
  }
  #endif
}

#if os(OSX)
private extension DataHandler {
  private func makeTextField(_ table: NSTableView) -> NSTextField {
    let tf = NSTextField(frame: NSRect(x: 0, y: 0, width: table.frame.size.width, height: 0))
    return tf
  }
  
  private func fetchIndexOfColumnIn(_ tableView: NSTableView, tableColumn: NSTableColumn?) -> Int? {
    let index = tableView.tableColumns.firstIndex(where: { $0 == tableColumn })
    return index
  }
}
#endif
