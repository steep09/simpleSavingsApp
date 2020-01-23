//
//  Months.swift
//  simpleSavings
//
//  Created by Stephenson Ang on 1/12/20.
//  Copyright © 2020 Stephenson Ang. All rights reserved.
//

import Foundation

class ExpenseDetailsModel {
    
    var expenseName: String!
    var expensePrice: Double!
    var dateOfExpense: String!
    
    init(expenseName: String, expensePrice: Double) {
        self.expenseName = expenseName
        self.expensePrice = expensePrice
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "MMMM dd, yyyy"
        let dateString = df.string(from: date)
        
        self.dateOfExpense = dateString
    }
    
}
