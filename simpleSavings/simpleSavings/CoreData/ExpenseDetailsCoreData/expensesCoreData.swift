//
//  expensesDetailCoreData.swift
//  simpleSavings
//
//  Created by Stephenson Ang on 1/23/20.
//  Copyright © 2020 Stephenson Ang. All rights reserved.
//

import UIKit
import CoreData

extension MainViewController {
    
    func retrieveExpensesDetailData() {
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appdelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ExpenseDetails")
        
        do {
            let result = try managedContext.fetch(request)
            for data in result as! [NSManagedObject] {
                expensesLogList.append(ExpenseModel(month: data.value(forKey: "month") as! String, totalExpense: data.value(forKey: "totalMonthlyExpense") as! Double))
                
            }
            print("\(expensesLogList.count)")
        } catch {
            print("Failed")
        }
        
    }
}
