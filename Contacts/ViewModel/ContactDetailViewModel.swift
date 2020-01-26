//
//  ContactDetailViewModel.swift
//  Contacts
//
//  Created by Ashutosh Roy on 27/01/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import UIKit

class ContactDetailViewModel {
    private var contacts: [ContactModel]?
    private var contactsDetail : ContactDetailModel?
    
    private let networking = Networking()
    
    public func getContactDetails(url: String, completion: ((_ response: ContactDetailModel) -> Void)?) {
        networking.performNetworkTaskDetail(endpoint: url,
                                      type: ContactDetailModel.self) { [weak self] (response) in
                                        self?.contactsDetail = response
//                                        completion?()
                                        completion?(response)
        }
    }
    
    public func getDetails()->ContactDetailModel{
        return self.contactsDetail!
    }
    
}
