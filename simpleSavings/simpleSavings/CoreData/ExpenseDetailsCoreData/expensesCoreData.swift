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
    
    func createExpensesData(lists: [ExpenseModel]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedcontext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Expenses", in: managedcontext)!
        
        let expenses = NSManagedObject(entity: userEntity, insertInto: managedcontext)
        
        for data in lists {
            print("--- \(data.month)")
            let expenses = NSManagedObject(entity: userEntity, insertInto: managedcontext)
            expenses.setValue(data.month, forKey: "month")
            expenses.setValue(data.totalExpense, forKey: "totalExpense")
        }
        
        do {
            try managedcontext.save()
        } catch let error as NSError {
            print("could not save data \(error), \(error.userInfo)")
        }
    }
    
}
