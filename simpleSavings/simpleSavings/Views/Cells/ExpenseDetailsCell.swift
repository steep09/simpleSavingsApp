//
//  ExpenseCell.swift
//  simpleSavings
//
//  Created by Stephenson Ang on 1/12/20.
//  Copyright © 2020 Stephenson Ang. All rights reserved.
//

import UIKit

class ExpenseDetailsCell: UITableViewCell {
    
    @IBOutlet weak var expenseName: UILabel!
    @IBOutlet weak var expensePrice: UILabel!
    @IBOutlet weak var dateOfExpense: UILabel!
    
    var expenseprice : NSNumber = 0
    
    func currencyFormatter() -> NumberFormatter {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        return currencyFormatter
    }

    func configureCell(expense: ExpenseDetailsModel) {
        self.expenseName.text = expense.expenseName
        
        self.expenseprice = NSNumber(value: expense.expensePrice)
        let priceString = self.currencyFormatter().string(from: self.expenseprice)!
        
        self.expensePrice.text = priceString
        self.dateOfExpense.text = expense.dateOfExpense
    }
}
