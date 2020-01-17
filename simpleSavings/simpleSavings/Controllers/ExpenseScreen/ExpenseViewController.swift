//
//  ExpenseViewController.swift
//  simpleSavings
//
//  Created by Stephenson Ang on 1/14/20.
//  Copyright © 2020 Stephenson Ang. All rights reserved.
//

import UIKit

class ExpenseViewController: UIViewController {
    
    @IBOutlet weak var expenseView: UIView!
    @IBOutlet weak var addExpenseBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var expenseNameTxtField: UITextField!
    @IBOutlet weak var expensePriceTxtField: UITextField!
    @IBOutlet weak var totalExpenseLbl: UILabel!
    
    var expenseSample : Expense!
    var expenseList = [Expense]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        expenseView.universalViewDesign()
        addExpenseBtn.universalButtonDesign()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        expenseSample = Expense(expenseName: "Netflix", expensePrice: "₱650.00")
        expenseList.append(expenseSample)
        
        
    }
    
    @IBAction func addExpenseBtnWasPressed(_ sender: Any) {
        
        expenseSample = Expense(expenseName: expenseNameTxtField.text ?? "", expensePrice: expensePriceTxtField.text ?? "")
        expenseList.append(expenseSample)
        tableView.reloadData()
        expenseNameTxtField.text = ""
        expensePriceTxtField.text = ""
    }
    
}
