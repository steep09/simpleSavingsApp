//
//  MonthlyTotal.swift
//  simpleSavings
//
//  Created by Stephenson Ang on 1/15/20.
//  Copyright © 2020 Stephenson Ang. All rights reserved.
//

import Foundation

class ExpenseModel {
    
    var month: String!
    var totalExpense: Double!
    
    init(month: String, totalExpense: Double) {
        self.month = month
        self.totalExpense = totalExpense
    }
}
