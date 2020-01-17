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
    @IBOutlet weak var addExpenseBtn: UIButton!
    
    @IBOutlet weak var totalYearlyExpense: UILabel!
    var expenseYearly : NSNumber = 0
    
    var monthlyTotalSample : MonthlyTotal!
    var monthlyTotalList = [MonthlyTotal]()
    var totalSaved : NSNumber = 0
    
    let firstRun = UserDefaults.standard.bool(forKey: "firstRun") as Bool
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savingsView.universalViewDesign()
        editSavingsBtn.universalButtonDesign()
        
        expenseView.universalViewDesign()
        addExpenseBtn.universalButtonDesign()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = .white
        
        monthlyTotalSample = MonthlyTotal(month: "January", totalExpense: "₱0.00")
        monthlyTotalList.append(monthlyTotalSample)
        
        if firstRun {
            //function you want to run normally
            retieveData()
        } else {
            runFirst() //will only run once
            retieveData()
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
        createData()
        UserDefaults.standard.set(true, forKey: "firstRun")
    }
    
    func retieveData() {
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appdelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Savings")
        
        do {
            let result = try managedContext.fetch(request)
            print("\(result[0])")
            print("----------")
            for data in result as! [NSManagedObject] {
                
                let priceString = self.currencyFormatter().string(from: self.totalSaved)!
                self.totalSavedLbl.text = "\(priceString)"
                
                print("\(data.value(forKey: "totalSaved"))")
                
            }
        } catch {
            print("Failed")
        }
        
    }
    
    func createData() {
        //ADDING TO COREDATA
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedcontext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Savings", in: managedcontext)!
        
        let savings = NSManagedObject(entity: userEntity, insertInto: managedcontext)
        
        savings.setValue(totalSaved, forKey: "totalSaved")
        
        do {
            try managedcontext.save()
        } catch let error as NSError {
            print("could not save data \(error), \(error.userInfo)")
        }
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
                
                
            } else if math == "Subtract" {
                totalNumber = Double(gotNumber) - Double(newNumber)
            } else {
//                TEMPORARY DISABLE THIS FUNCTION 
//                totalNumber = Double(gotNumber) - Double(newNumber)
//
//                let nameTxtField = alert?.textFields?[0]
//                let priceTxtField = alert?.textFields?[1]
//
//                // We'll force unwrap with the !, if you've got defined data you may need more error checking
//                let priceTxt : NSNumber = NSNumber(value: Double(priceTxtField?.text ?? "0") ?? 0.0)
//                let priceString = self.currencyFormatter().string(from: priceTxt)
//                self.totalSavedLbl.text = "\(priceString)"
//
//                self.expenseList.append(Expense(month: nameTxtField?.text ?? "ANONYMOUS", expense: priceString ?? "0"))
//                self.tableView.reloadData()
//
//                //For TotalYearlyExpense
//                let yearlyExpense = Double(self.expenseYearly) + Double(priceTxt)
//                self.expenseYearly = NSNumber(value: yearlyExpense)
//                let totalExpense = self.currencyFormatter().string(from: self.expenseYearly)
//                self.totalYearlyExpense.text = totalExpense
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
    
    @IBAction func addExpenseBtnWasPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Adding Expense", message: "How much is it?", preferredStyle: .alert)
        
        alert.addTextField { (textfield) in
            textfield.placeholder = "Enter name"
        }
        
        alert.addTextField { (textfield) in
            textfield.keyboardType = .decimalPad
            textfield.placeholder = "Enter number"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        editSavingsFunction(alert: alert, math: "-", textFieldRow: 1)
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
