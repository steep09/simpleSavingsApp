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
        
        //CHECK IF THE CURRENT MONTH IS THE SAME AS THE MONTH IN THE LABEL
        if cell.month.text != monthToString {
            cell.isUserInteractionEnabled = false
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "YEARLY LOG"
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 100, width: 350, height: 100)) //set these values as necessary
        returnedView.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)

        let label = UILabel(frame: CGRect(x: 10, y: 5, width: returnedView.frame.size.width, height: 20))

        label.text = "YEARLY LOG"
        label.textColor = .white
        returnedView.addSubview(label)

        return returnedView
    }
    
}
