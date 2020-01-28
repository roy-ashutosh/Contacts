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
    
    func performNetworkTaskWithBody<T: Codable>(endpoint: Any,
                                        type: T.Type,
                                        httpMethod: String,
                                        bodyData: Data?,
                                        completion: ((_ response: T) -> Void)?) {
        
        guard let url = URL(string: endpoint as! String) else { return }

        var request = URLRequest.init(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyData
        performDataTask(request: request)
        
    }
    
    func performDataTask(request:URLRequest){
                
                //DataTask
                
                let session = URLSession.shared
                
                let task = session.dataTask(with: request){(data,response,error)in
                    
                    let httpResponse  = response as? HTTPURLResponse
                    
                    if let data = data {
                        if httpResponse?.statusCode == 200{
                            print(data)
                            print("API RequestURL: \(request.url?.relativeString ?? "")")
                        }else{
                            
                        }
                    }else{
                        
                    }
                    
                }
                
                task.resume()
                
            }
}
