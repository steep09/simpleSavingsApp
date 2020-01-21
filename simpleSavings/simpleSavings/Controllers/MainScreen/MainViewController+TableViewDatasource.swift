//
//  MainViewController+TableViewDatasource.swift
//  simpleSavings
//
//  Created by Stephenson Ang on 1/14/20.
//  Copyright © 2020 Stephenson Ang. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthlyTotalList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MonthlyTotalCell") as? MonthlyTotalCell else { return UITableViewCell() }
        let monthlyTotalCount = monthlyTotalList[indexPath.row]
        
        cell.configureCell(monthlyTotal: monthlyTotalCount)
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "MMMM"
        let monthToString = df.string(from: date)
        print(monthToString)
        
        //CHECK IF THE CURRENT MONTH IS THE SAME AS THE MONTH IN THE LABEL
        if cell.month.text != monthToString {
            cell.isUserInteractionEnabled = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "YEARLY LOG"

    }
    
}
