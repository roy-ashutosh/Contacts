//
//  ContactListModel.swift
//  Contacts
//
//  Created by Ashutosh Roy on 27/01/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

struct ContactModel: Codable {
    
    let id : Int?
    let first_name : String?
    let last_name : String?
    let profile_pic : String?
    let favorite : Bool?
    let url : String?
}

struct ContactListModel: Codable {
    let items: [ContactModel]
    
    init(items: [ContactModel]) {
        self.items = items
    }
}

struct ContactDetailModel: Codable {

    let id : Int?
    let first_name : String?
    let last_name : String?
    let email : String?
    let phone_number : String?
    let profile_pic : String?
    let favorite : Bool?
}
