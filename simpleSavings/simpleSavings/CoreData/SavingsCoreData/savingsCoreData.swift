//
//  savingsCoreData.swift
//  simpleSavings
//
//  Created by Stephenson Ang on 1/21/20.
//  Copyright © 2020 Stephenson Ang. All rights reserved.
//

import UIKit
import CoreData

extension MainViewController {
    
    //READ CORE DATA
    func retrieveSavingsData() {
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appdelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Savings")
        
        do {
            let result = try managedContext.fetch(request)
            for data in result as! [NSManagedObject] {
                
                self.totalSaved = NSNumber(value: data.value(forKey: "totalSaved") as! Double)
                let priceString = self.currencyFormatter().string(from: self.totalSaved)!
                self.totalSavedLbl.text = "\(priceString)"
                
//                print("\(data.value(forKey: "totalSaved"))")
                
            }
        } catch {
            print("Failed")
        }
        
    }
    
    //UPDATE CORE DATA
    func updateSavingsData(updateSaved: Double) {
        
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appdelegate.persistentContainer.viewContext
        
        let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Savings")
        
        do {
            let update = try managedContext.fetch(request)
            
            let updateObject = update[0] as! NSManagedObject
            updateObject.setValue(updateSaved, forKey: "totalSaved")
            self.totalSaved = NSNumber(value: updateSaved)
            let priceString = self.currencyFormatter().string(from: self.totalSaved)!
            
            self.totalSavedLbl.text = "\(priceString)"
            do {
                try managedContext.save()
            } catch {
                print("Can not update object")
            }
        } catch {
            
        }
    }
    //ADD COREDATA
    func createSavingsData() {
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
}
