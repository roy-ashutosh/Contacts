//
//  ContactListViewModel.swift
//  Contacts
//
//  Created by Ashutosh Roy on 27/01/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

class ContactListViewModel {
    
    private var contacts: [ContactModel]?
    
    private let networking = Networking()
    
    public func getContactList(completion: (() -> Void)?) {
        networking.performNetworkTask(endpoint: "",
                                      type: [ContactModel].self) { [weak self] (response) in
                                        self?.contacts = response
                                        completion?()
        }
    }
    
    public var count: Int {
        return contacts?.count ?? 0
    }
    
    public func cellViewModel(index: Int)->ContactModel{
        return (contacts?[index])!
    }
    
}
