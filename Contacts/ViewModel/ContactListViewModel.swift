//
//  ContactListViewModel.swift
//  Contacts
//
//  Created by Ashutosh Roy on 27/01/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//
import Foundation
//import CoreData

class ContactListViewModel {
    
//    private var contacts: [ContactModel]?
    private var contacts: [Contact]?
    
    private let networking = Networking()
    private let dbUtil = DataBaseUtil()
    
    public func getContactList(completion: (() -> Void)?) {
        networking.performNetworkTask(endpoint: "https://gojek-contacts-app.herokuapp.com/contacts.json",
                                      type: [ContactModel].self) { [weak self] (response) in
//                                        self?.contacts = response
                                        self?.dbUtil.saveContactListInDb(list: response)
                                        completion?()
        }
    }
    
    public var count: Int {
        return contacts?.count ?? 0
    }
    
    public func cellViewModel(index: Int)->Contact{
        return (contacts?[index])!
    }
    
    func updateContactListEntity() {
        self.contacts = nil
        self.contacts = dbUtil.fetchContacts()
        
    }
    
}
