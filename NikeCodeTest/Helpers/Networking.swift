//
//  Networking.swift
//  NikeCodeTest
//
//  Created by Miguel Perez on 10/3/19.
//  Copyright © 2019 Miguel Perez. All rights reserved.
//

import Foundation


class Networking {
    
    //Singleton
    static let sharedInstance = Networking()
    
    //Http Method Helpers
    public func get( request: URLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "GET", completion: completion)
    }
    
    public func post( request: URLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "POST", completion: completion)
    }
    
    public func put( request: URLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "PUT", completion: completion)
    }
    
    public func delete( request: URLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "DELETE", completion: completion)
    }
    
    
    private func dataTask( request: URLRequest, method: String, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
       
        var request = request
        request.httpMethod = method
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request) { (data, response, error) -> Void in
            
            if let data = data {
                
                //let json = try? JSONSerialization.jsonObject(with: data, options: [])
                /// Success (200...299) - The action was successfully received, understood, and accepted.
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, data as AnyObject)
                } else {
                    completion(false, data as AnyObject)
                }
            }
        }.resume()
    }
    
    
    public func clientURLRequest(path: String, params: [String: AnyObject]? = nil, token: String? = nil) -> URLRequest? {
       
        guard let url = URL(string: path) else { return nil }
        
        var request = URLRequest(url: url)
        if let params = params {
           
            var paramString = ""
            for (key, value) in params {
                let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                let escapedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                paramString += "\(escapedKey)=\(escapedValue)&"
            }
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = paramString.data(using: String.Encoding.utf8)
        }
        
        if let token = token {
            
            request.addValue("Bearer "+token, forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}
