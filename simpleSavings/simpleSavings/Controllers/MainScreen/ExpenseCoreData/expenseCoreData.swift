//
//  expenseCoreData.swift
//  simpleSavings
//
//  Created by Stephenson Ang on 1/22/20.
//  Copyright © 2020 Stephenson Ang. All rights reserved.
//

import UIKit
import  CoreData

extension MainViewController {
    
    func retrieveExpensesData() {
            
            guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appdelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Expenses")
            
            do {
                let result = try managedContext.fetch(request)
                for data in result as! [NSManagedObject] {
                    print(result.count)
                    expensesLogList.append(MonthlyTotal(month: data.value(forKey: "month") as! String, totalExpense: data.value(forKey: "totalMonthlyExpense") as! Double))
                    
                }
                print("\(expensesLogList.count)")
            } catch {
                print("Failed")
            }
            
        }
    
    func createExpenseData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedcontext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Expenses", in: managedcontext)!
        
        
        
        var x = 0
        print("-----\(monthlyTotalList.count)")
        while x < monthlyTotalList.count {
            let expenses = NSManagedObject(entity: userEntity, insertInto: managedcontext)
            
            expenses.setValue(monthlyTotalList[x].month, forKey: "month")
            expenses.setValue(monthlyTotalList[x].totalExpense, forKey: "totalMonthlyExpense")
            x += 1
        }
        
        do {
            try managedcontext.save()
        } catch let error as NSError {
            print("could not save data \(error), \(error.userInfo)")
        }
    }
    
}
