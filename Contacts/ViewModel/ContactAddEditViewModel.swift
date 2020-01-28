//
//  ContactAddEditViewModel.swift
//  Contacts
//
//  Created by Ashutosh Roy on 28/01/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import UIKit

class ContactAddEditViewModel: NSObject {
    
    private let networking = Networking()

    func updateContactDetails(url: String,httpMethodType: String,paramDict: [String: String]) -> Void {
        
        let data = try! JSONSerialization.data(withJSONObject: paramDict, options: JSONSerialization.WritingOptions.prettyPrinted)

        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)

        let jsonData = json?.data(using: String.Encoding.utf8.rawValue) //data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)
        
//        networking.performNetworkTaskWithBody(endpoint: url, type: ContactDetailModel.self, bodyData: jsonData) { (response) in
        
        networking.performNetworkTaskWithBody(endpoint: url, type: ContactDetailModel.self, httpMethod: httpMethodType, bodyData: jsonData) { (response) in
            
        }
            
    }
}
