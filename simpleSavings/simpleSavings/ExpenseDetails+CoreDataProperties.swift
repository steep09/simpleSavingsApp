//
//  ExpenseDetails+CoreDataProperties.swift
//  simpleSavings
//
//  Created by Stephenson Ang on 1/22/20.
//  Copyright © 2020 Stephenson Ang. All rights reserved.
//
//

import Foundation
import CoreData


extension ExpenseDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseDetails> {
        return NSFetchRequest<ExpenseDetails>(entityName: "ExpenseDetails")
    }

    @NSManaged public var dateOfPurchase: Date?
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var expense: Expenses?

}
