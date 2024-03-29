//
//  CoreDataHelper.swift
//  Receipt Reviewer
//
//  Created by Linglong Wang on 7/13/17.
//  Copyright © 2017 Connar Wang. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    
    //static methods will go here
    static func newReceipt() -> Receipt {
        let receipt = NSEntityDescription.insertNewObject(forEntityName: "Receipt", into: managedContext) as! Receipt
        return receipt
    }
    static func saveReceipt() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    static func delete(receipt: Receipt) {
        managedContext.delete(receipt)
        saveReceipt()
    }
    static func retrieveReceipts() -> [Receipt] {
        let fetchRequest = NSFetchRequest<Receipt>(entityName: "Receipt")
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return []
    }
    
// Item entity static func:
    static func newItem()-> Item{
    let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: managedContext) as! Item
    return item
    }
    static func saveItem() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    static func deleteItem(item: Item) {
        managedContext.delete(item)
        saveItem()
    }
    static func retrieveItems(withID ID: String) -> [Item] {
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        
        fetchRequest.predicate = NSPredicate(format: "itemID == %@", ID)
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return []
    }

    
}
