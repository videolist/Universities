//
//  TKRealmDataSource.swift
//  Token
//
//  Created by Vadim on 10/9/16.
//

import UIKit
import RealmSwift
import BoltsSwift

protocol SectionDelegate: UITableViewDelegate, UITableViewDataSource {
    
}


class TableViewRouter: NSObject, SectionDelegate {
    
    var delegates: [SectionDelegate]!
    weak var tableView: UITableView!
    
    required init(_ tableView: UITableView, delegates: [SectionDelegate]) {
        super.init()
        self.tableView = tableView
        tableView.delegate = self
        tableView.dataSource = self
        self.delegates = delegates
    }

    
    //MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return delegates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegates[section].tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let returnValue = delegates[indexPath.section].tableView?(tableView, heightForRowAt: indexPath) {
            return returnValue
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return delegates[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        delegates[indexPath.section].tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegates[indexPath.section].tableView?(tableView, didSelectRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return delegates[section].tableView?(tableView, viewForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let returnValue = delegates[section].tableView?(tableView, heightForHeaderInSection: section) {
            return returnValue
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return delegates[section].tableView?(tableView, viewForFooterInSection: section)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if let returnValue = delegates[indexPath.section].tableView?(tableView, editingStyleForRowAt: indexPath) {
            return returnValue
        }
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        if let returnValue = delegates[indexPath.section].tableView?(tableView, shouldIndentWhileEditingRowAt: indexPath) {
            return returnValue
        }
        return false
    }

}

class GenericTableDataSource: NSObject, SectionDelegate {

    var selectedCallback: ((AnyObject) -> Void)?
    var configureCallback: ((TableViewCell) -> Void)?
    var changeCallback: ((Void) -> Void)?
    var editButtonTitle: String?
    var editCallback: ((AnyObject) -> Void)?

    weak var tableView: UITableView!
    var delegateRouter: TableViewRouter!
    var headerView: UIView?
    var headerDelegate: SectionDelegate?
    
    var count: NSInteger = 0
    
    var section: NSInteger = 0

    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        delegateRouter = TableViewRouter(tableView, delegates: [self])
    }
    
    init(tableView: UITableView, section: Int, headerDelegate: SectionDelegate? = nil) {
        super.init()
        self.section = section
        self.tableView = tableView
        self.headerDelegate = headerDelegate
    }
    
    func stopObserving() {
    }
    

    var filterPredicate: NSPredicate?
    
    //MARK: UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if headerDelegate != nil {
            return headerDelegate?.tableView?(tableView, viewForHeaderInSection: section)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let returnValue = headerDelegate?.tableView?(tableView, heightForHeaderInSection: section) {
            return returnValue
        }
        if headerView != nil {
            return headerView!.frame.size.height
        }
        return 0
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    
}

class RealmDataSource<R: RealmObject, Cell: TableViewCell> : GenericTableDataSource {
    var notificationToken: NotificationToken?
    var loadMoreTask: Task<Void>? {
        return Task<Void>()
    }
    var lastLoadTask = Task<Void>()
    
    var collection: AnyRealmCollection<R>! {
        didSet {
            startObservingRealm()
        }
    }

    var filteredCollection: AnyRealmCollection<R> {
        var actualCollection = collection!
        if filterPredicate != nil {
            actualCollection = AnyRealmCollection(actualCollection.filter(filterPredicate!))
        }
        if sortDescriptors != nil {
            actualCollection = AnyRealmCollection(actualCollection.sorted(by: sortDescriptors!))
        }
        return actualCollection
    }
    
    var sortDescriptors: [SortDescriptor]? {
        return nil
    }
    
    
    override var filterPredicate: NSPredicate? {
        didSet {
            startObservingRealm()
        }
    }

    var items: [R]? {
        return Array(self.filteredCollection)
    }
    
    convenience init(_ tableView: UITableView) {
        self.init(tableView, collection: RealmObject.allObjects(type: R.self))
    }
    
    convenience init(_ tableView: UITableView, section: Int, headerDelegate: SectionDelegate? = nil) {
        self.init(tableView, section: section, collection: R.allObjects(type: R.self), headerDelegate: headerDelegate)
    }
    
    convenience init<C: RealmCollection>(_ tableView: UITableView, collection: C) where C.Element == R  {
        self.init(tableView: tableView)
        self.startObservingRealm(for: collection)
    }
    
    convenience init<C: RealmCollection>(_ tableView: UITableView, section: Int, collection: C, headerDelegate: SectionDelegate? = nil) where C.Element == R  {
        self.init(tableView: tableView, section: section, headerDelegate: headerDelegate)
        self.startObservingRealm(for: collection)
    }
    
    override init(tableView: UITableView) {
        super.init(tableView: tableView)
        tableView.register(Cell.nib, forCellReuseIdentifier: Cell.nibName)
    }
    
    override init(tableView: UITableView, section: Int, headerDelegate: SectionDelegate? = nil) {
        super.init(tableView: tableView, section: section, headerDelegate: headerDelegate)
        tableView.register(Cell.nib, forCellReuseIdentifier: Cell.nibName)
    }
    
    func startObservingRealm<C: RealmCollection>(for collection: C) where C.Element == R {
        self.collection = AnyRealmCollection(collection)
        startObservingRealm()
    }
    
    func startObservingRealm() {
        notificationToken?.stop()
        
        // Observe Results Notifications
        notificationToken = filteredCollection.addNotificationBlock { [unowned self] (changes: RealmCollectionChange) in
            guard let tableView = self.tableView else { return }
            self.count = self.filteredCollection.count
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                //                print("number of objects \(self!.objects.count) in section \(self!.collectionSection) in \(self!)")
                tableView.reloadSections([self.section], with: .none)
                self.changeCallback?()
                break;
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                print("deletions \(deletions) insertions \(insertions) modifications \(modifications) in \(self)")
                tableView.beginUpdates()
                if insertions.count > 0 {
                    tableView.insertRows(at: insertions.map {IndexPath.init(row: $0, section: self.section)}, with: .none)
                }
                if deletions.count > 0 {
                    tableView.deleteRows(at: deletions.map {IndexPath.init(row: $0, section: self.section)}, with: .top)
                }
                if modifications.count > 0 {
                    tableView.reloadRows(at: modifications.map {IndexPath.init(row: $0, section: self.section)}, with: .none)
                }
                tableView.endUpdates()
                if insertions.count > 0 || deletions.count > 0 {
                    self.changeCallback?()
                }
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
            }
        }
    }
    
    override func stopObserving() {
        notificationToken?.stop()
    }

    deinit {
        stopObserving()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Cell.viewHeightInNib()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.nibName, for: indexPath) as! TableViewCell
        cell.item = items?[indexPath.row]
        tableView.allowsSelection = true
        
        configureCallback?(cell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCallback?(items![indexPath.row])
    }
    
}
