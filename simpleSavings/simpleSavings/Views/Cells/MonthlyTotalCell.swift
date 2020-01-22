//
//  MonthlyTotalCell.swift
//  simpleSavings
//
//  Created by Stephenson Ang on 1/15/20.
//  Copyright © 2020 Stephenson Ang. All rights reserved.
//

import UIKit

class MonthlyTotalCell: UITableViewCell {

    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var totalExpense: UILabel!

    var monthlyExpense : NSNumber = 0
    
    func currencyFormatter() -> NumberFormatter {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        return currencyFormatter
    }
    
    func configureCell(monthlyTotal: MonthlyTotal) {
        self.month.text = monthlyTotal.month
        
        self.monthlyExpense = NSNumber(value: 0.00)
        let priceString = self.currencyFormatter().string(from: self.monthlyExpense)!
        
        self.totalExpense.text = priceString
    }
    
}
