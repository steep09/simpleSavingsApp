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

    func configureCell(monthlyTotal: MonthlyTotal) {
        self.month.text = monthlyTotal.month
        self.totalExpense.text = monthlyTotal.totalExpense
    }
    
}
