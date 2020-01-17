//
//  ExpenseVieController+TableViewDatasource.swift
//  simpleSavings
//
//  Created by Stephenson Ang on 1/15/20.
//  Copyright © 2020 Stephenson Ang. All rights reserved.
//

import UIKit

extension ExpenseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        expenseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell") as? ExpenseCell else { return UITableViewCell() }
        let expenseCount = expenseList[indexPath.row]
        
        cell.configureCell(expense: expenseCount)
        
        return cell
    }
    
    
}
