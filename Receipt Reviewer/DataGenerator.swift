//
//  DataGenerator.swift
//  Receipt Reviewer
//
//  Created by Linglong Wang on 8/3/17.
//  Copyright © 2017 Connar Wang. All rights reserved.
//

import Foundation
struct MonthlySpense {
    var month: String
    var value: Double
}

class DataGenerator {
    var chartV = ChartViewController()
    static var receipts = [Receipt]()
    static var monthlyTotals = [Double]()
    var tempSameMonth = [Receipt]()
    var tempTotal = 0.0
    var startYear: Int16 = 0
    var endYear: Int16 = 0
    
  
    func sortDated(receiptsToSort sortThis: [Receipt]) -> [Receipt] {
        
        let result = sortThis.sorted(by: {
            let date0 = $0.date! as Date
            let date1 = $1.date! as Date
            return date0 < date1
        })
        print(result)
        
        return result
        
    }
    
    
    func dataBuild() -> [Double]{
        //setting end and start year
        for r in 1..<DataGenerator.receipts.count{
            if DataGenerator.receipts[r].year <= DataGenerator.receipts[r-1].year{
                startYear = DataGenerator.receipts[r].year
            }else{
                startYear = DataGenerator.receipts[r-1].year
            }
        }
        for t in 1..<DataGenerator.receipts.count{
            if DataGenerator.receipts[t].year >= DataGenerator.receipts[t-1].year{
                endYear = DataGenerator.receipts[t].year
            }else{
                endYear = DataGenerator.receipts[t-1].year
            }
        }
        print(startYear)
        print(endYear)
        //the retrieve starts here
        for y in startYear...endYear{
            for m in 1...12{
                tempTotal = 0.0
                tempSameMonth = sortDated(receiptsToSort: DataGenerator.receipts).filter {($0.month == Int16(m) ) && ($0.year == y)}
                
                for i in 0..<tempSameMonth.count{
                    tempTotal += tempSameMonth[i].total
                }
                DataGenerator.monthlyTotals.append(tempTotal)
            }
        }
        return DataGenerator.monthlyTotals
    }

    
    static func data() -> [MonthlySpense] {
        
        receipts = CoreDataHelper.retrieveReceipts()
        dataBuild(DataGenerator.receipts)
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        var monthlySpenses = [MonthlySpense]()
        var index = 0
        for month in months {
            
            let monthlySpense = MonthlySpense(month: month, value: monthlyTotals[index])
            monthlySpenses.append(monthlySpense)
            index += 1
        }
        
        return monthlySpenses
    }
}
