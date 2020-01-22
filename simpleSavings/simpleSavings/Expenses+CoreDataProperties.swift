//
//  Expenses+CoreDataProperties.swift
//  simpleSavings
//
//  Created by Stephenson Ang on 1/22/20.
//  Copyright © 2020 Stephenson Ang. All rights reserved.
//
//

import Foundation
import CoreData


extension Expenses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expenses> {
        return NSFetchRequest<Expenses>(entityName: "Expenses")
    }

    @NSManaged public var month: String?
    @NSManaged public var totalMonthlyExpense: Double
    @NSManaged public var details: NSSet?

}

// MARK: Generated accessors for details
extension Expenses {

    @objc(addDetailsObject:)
    @NSManaged public func addToDetails(_ value: ExpenseDetails)

    @objc(removeDetailsObject:)
    @NSManaged public func removeFromDetails(_ value: ExpenseDetails)

    @objc(addDetails:)
    @NSManaged public func addToDetails(_ values: NSSet)

    @objc(removeDetails:)
    @NSManaged public func removeFromDetails(_ values: NSSet)

}
