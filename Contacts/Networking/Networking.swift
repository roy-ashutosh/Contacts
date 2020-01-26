//
//  Networking.swift
//  Contacts
//
//  Created by Ashutosh Roy on 27/01/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import Foundation

class Networking {

    func performNetworkTask<T: Codable>(endpoint: Any,
                                        type: T.Type,
                                        completion: ((_ response: T) -> Void)?) {
        
        let urlString = "https://gojek-contacts-app.herokuapp.com/contacts.json"
        guard let urlRequest = URL(string: urlString ?? "") else { return }

        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let _ = error {
                return
            }
            guard let data = data else {
                return
            }
            let response = Response(data: data)
            guard let decoded = response.decode(type) else {
                return
            }
            completion?(decoded)
        }
        urlSession.resume()
    }
    
    
    func performNetworkTaskDetail<T: Codable>(endpoint: Any,
                                        type: T.Type,
                                        completion: ((_ response: T) -> Void)?) {
        
        let urlString = "https://gojek-contacts-app.herokuapp.com/contacts.json"
        guard let urlRequest = URL(string: endpoint as! String) else { return }

        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            if let _ = error {
                return
            }
            guard let data = data else {
                return
            }
            let response = Response(data: data)
            guard let decoded = response.decode(type) else {
                return
            }
            completion?(decoded)
        }
        urlSession.resume()
    }

}
