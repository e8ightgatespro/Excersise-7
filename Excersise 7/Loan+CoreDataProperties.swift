//
//  Loan+CoreDataProperties.swift
//  Excersise 7
//
//  Created by Voss, Garrett on 4/30/18.
//  Copyright © 2018 Voss, Garrett. All rights reserved.
//
//

import Foundation
import CoreData


extension Loan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Loan> {
        return NSFetchRequest<Loan>(entityName: "Loan")
    }

    @NSManaged public var accountNumber: String?
    @NSManaged public var amount: String?
    @NSManaged public var currentBalance: String?
    @NSManaged public var customerNumber: String?
    @NSManaged public var initialBalance: String?
    @NSManaged public var interestRate: String?

}
