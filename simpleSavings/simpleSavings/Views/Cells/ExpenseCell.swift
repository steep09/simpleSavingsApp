//
//  ExpenseCell.swift
//  simpleSavings
//
//  Created by Stephenson Ang on 1/12/20.
//  Copyright © 2020 Stephenson Ang. All rights reserved.
//

import UIKit

class ExpenseCell: UITableViewCell {
    
    @IBOutlet weak var expenseName: UILabel!
    @IBOutlet weak var expensePrice: UILabel!
    @IBOutlet weak var dateOfExpense: UILabel!

    func configureCell(expense: ExpenseDetailsModel) {
        self.expenseName.text = expense.expenseName
        self.expensePrice.text = expense.expensePrice
        self.dateOfExpense.text = expense.dateOfExpense
    }
}
