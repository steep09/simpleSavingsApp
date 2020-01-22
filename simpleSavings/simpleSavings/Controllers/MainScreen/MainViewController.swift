//
//  ViewController.swift
//  simpleSavings
//
//  Created by Stephenson Ang on 1/8/20.
//  Copyright © 2020 Stephenson Ang. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    @IBOutlet weak var savingsView: UIView!
    @IBOutlet weak var editSavingsBtn: UIButton!
    
    @IBOutlet weak var totalSavedLbl: UILabel!
    @IBOutlet weak var dateTodayLbl: UILabel!
    
    @IBOutlet weak var expenseView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalYearlyExpense: UILabel!
    var expenseYearly : NSNumber = 0
    
    var monthlyTotalSample : MonthlyTotal!
    var monthlyTotalList : [MonthlyTotal] =
        [MonthlyTotal(month: "January", totalExpense: 0.00),
         MonthlyTotal(month: "Febuary", totalExpense: 0.00),
         MonthlyTotal(month: "March", totalExpense: 0.00),
         MonthlyTotal(month: "April", totalExpense: 0.00),
         MonthlyTotal(month: "May", totalExpense: 0.00),
         MonthlyTotal(month: "June", totalExpense: 0.00),
         MonthlyTotal(month: "July", totalExpense: 0.00),
         MonthlyTotal(month: "August", totalExpense: 0.00),
         MonthlyTotal(month: "September", totalExpense: 0.00),
         MonthlyTotal(month: "October", totalExpense: 0.00),
         MonthlyTotal(month: "November", totalExpense: 0.00),
         MonthlyTotal(month: "December", totalExpense: 0.00)
    ]
    var expensesLogList = [MonthlyTotal]()
    var totalSaved : NSNumber = 0
    
    let firstRun = UserDefaults.standard.bool(forKey: "firstRun") as Bool
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savingsView.universalViewDesign()
        editSavingsBtn.universalButtonDesign()
        
        expenseView.universalViewDesign()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 10.0
        tableView.layer.borderWidth = 2.0
        tableView.layer.borderColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        
        if firstRun {
            //function you want to run normally
            retrieveExpensesData()
            retrieveSavingsData()
        } else {
            runFirst() //will only run once
            createExpenseData()
            retrieveExpensesData()
            retrieveSavingsData()
            
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "MMMM dd, yyyy"
        let dateString = df.string(from: date)
        dateTodayLbl.text = dateString
    }

}
extension MainViewController {
    
    func runFirst() {
        print("FIRST RUN!")
        createSavingsData()
        UserDefaults.standard.set(true, forKey: "firstRun")
    }
    
    func currencyFormatter() -> NumberFormatter {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        return currencyFormatter
    }
    
    func editSavingsFunction(alert: UIAlertController, math: String, textFieldRow: Int) {
        
        alert.addAction(UIAlertAction(title: math, style: .default, handler: { [weak alert] (_) in
            
            let textField = alert?.textFields?[textFieldRow]
            let gotNumber = Double(self.totalSaved)
            
            var newNumber : Int = 0
            if (textField?.text!.isEmpty)! {
                newNumber = 0
            } else {
                newNumber = Int(textField?.text ?? "0")!
            }
            
            
            var totalNumber : Double = 0
            if math == "Add" {
                totalNumber = Double(gotNumber) + Double(newNumber)
                self.updateSavingsData(updateSaved: totalNumber)
                
            } else if math == "Subtract" {
                totalNumber = Double(gotNumber) - Double(newNumber)
                self.updateSavingsData(updateSaved: totalNumber)
            } else {
                
            }
            
            self.totalSaved = NSNumber(value: totalNumber)
            let priceString = self.currencyFormatter().string(from: self.totalSaved)!
            self.totalSavedLbl.text = "\(priceString)"
            
        }))
        
    }
    
    @IBAction func editSavingsBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Adding money to Savings", message: "How much is it?", preferredStyle: .alert)
        
        alert.addTextField { (textfield) in
            textfield.keyboardType = .decimalPad
            textfield.placeholder = "Enter number"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        editSavingsFunction(alert: alert, math: "Add", textFieldRow: 0)
        editSavingsFunction(alert: alert, math: "Subtract", textFieldRow: 0)
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
