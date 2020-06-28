//
//  DataBaseUtil.swift
//  Contacts
//
//  Created by Ashutosh Roy on 27/06/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataBaseUtil {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func fetchContacts() -> [Contact] {
        var result = [Contact]()
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Contact> = Contact.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "first_name", ascending: true)]
        do {
            result = try context.fetch(request)
        } catch {
            print("Fatal error")
        }
        return result
    }
    
    func saveContactListInDb(list: [ContactModel]) {
        
        self.clearContactsInDB()
        
        let context = appDelegate.persistentContainer.newBackgroundContext()
        
        _ = list.map { contact in
            let req = Contact(context: context)
            req.id = String(contact.id ?? 0)
            req.first_name = contact.first_name
            req.last_name = contact.last_name
            req.profile_pic = contact.profile_pic
            req.favorite = contact.favorite ?? false
            req.url = contact.url
        }
        
        do {
            try context.save()
        } catch {
            
        }
    }
    
    func clearContactsInDB() {
        // create the delete request for the specified entity
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Contact.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        // perform the delete
        do {
            try appDelegate.persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
}
