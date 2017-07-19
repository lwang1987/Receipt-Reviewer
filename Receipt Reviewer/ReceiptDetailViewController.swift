//
//  ReceiptDetailViewController.swift
//  Receipt Reviewer
//
//  Created by Linglong Wang on 7/11/17.
//  Copyright © 2017 Connar Wang. All rights reserved.
//

import UIKit
import Foundation


class ReceiptDetailViewController: UIViewController{
    var receipt: Receipt?
    var item: Item?
    var items = [Item]() {
        didSet {
            tableView.reloadData()
        }
    }


    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    

    @IBAction func editButtonTapped(_ sender: Any) {

    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let receipt = receipt {
            // 2
            titleLabel.text = receipt.title
            dateLabel.text = receipt.date?.convertToString()
        } else {
            // 3
            titleLabel.text = ""
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if receipt == nil {
//            self.performSegue(withIdentifier: "edit", sender: nil)
//            
//        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if receipt != nil{
            items = CoreDataHelper.retrieveItems(withID: receipt!.receiptID!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "edit" {
            if let navVC = segue.destination as? UINavigationController {
                if let destinationVC = navVC.topViewController as? EditViewController {
                    destinationVC.receipt = receipt
                    destinationVC.isEditingReceipt = true
                }
            }
            
//            let editViewController = segue.destination as! EditViewController
//            editViewController.receipt = receipt
//            if let receipt = receipt {
//                // 1
//                receipt.title = titleLabel.text ?? ""
//                // 2
//                print("text load \(String(describing: receipt.title))")
//                
//            } else {
//                // 3
//                let receipt = self.receipt ?? CoreDataHelper.newReceipt()
//                print("receipt = \(receipt)")
//                receipt.title = titleLabel.text ?? ""
//                receipt.date = Date() as NSDate
//                CoreDataHelper.saveReceipt()
        }
        
    }

    @IBAction func unwindToReceiptDetailViewController(_ segue: UIStoryboardSegue) {
        
        
        
    }

}





extension ReceiptDetailViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            print("tableView = \(tableView)")
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        // 3
        let cell = tableView.dequeueReusableCell(withIdentifier: "receiptDetailViewCell", for: indexPath) as! ReceiptDetailViewCell
        print("Cell = \(cell)")
        // 2
        let row = indexPath.row

        let item = items[row]

        cell.itemNameLabel.text = item.name
        cell.itemPriceLabel.text = String(item.price)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("Cell Tapped")
    }

}







