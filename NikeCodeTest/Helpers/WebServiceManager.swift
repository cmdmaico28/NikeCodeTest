//
//  WebServiceManager.swift
//  NikeCodeTest
//
//  Created by Miguel Perez on 10/3/19.
//  Copyright © 2019 Miguel Perez. All rights reserved.
//

import Foundation
import UIKit


class WebServiceManager {
    
    //Singleton
    static let sharedInstance = WebServiceManager()
    
    var token: String? //if Authorization is required
    let baseURLString = "https://rss.itunes.apple.com"
    //https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json

    
    //MARK: GET Top Albums
    func getTopAlbums(limit: Int, completion: @escaping (_ success: Bool, _ errorMessage: String?, _ albumViewModel: AlbumViewModel?) -> ()) {
        
        let path = "\(baseURLString)/api/v1/us/apple-music/top-albums/all/\(limit)/explicit.json"
        guard let request = Networking.sharedInstance.clientURLRequest(path: path) else { return }
        
        Networking.sharedInstance.get(request: request) { (success, object) -> () in
            
            if success {
                
                guard let data = object as? Data else { return }
                
                guard let object = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                
                if let jsonFeed = object?["feed"] as? [String: AnyObject], let jsonArray = jsonFeed["results"] as? [[String: AnyObject]] {
                    
                    for item in jsonArray {
                        
                        guard let itemData = try? JSONSerialization.data(withJSONObject: item, options: JSONSerialization.WritingOptions.prettyPrinted) else { return }
                        
                        guard let album = try? JSONDecoder().decode(Album.self, from: itemData) else { return }
                        
                        DispatchQueue.main.async {
                            completion(true, nil, AlbumViewModel(album: album))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(false, nil, nil)
                    }
                }
            } else {
                let message = "There was an error"
                DispatchQueue.main.async {
                    completion(false, message, nil)
                }
            }
        }
    }
    
    //Func Download Image
     func downloadAlbumImage(urlPath: String, completion: @escaping (_ success: Bool, _ errorMessage: String?, _ image: UIImage?) -> ()) {
        
        guard let request = Networking.sharedInstance.clientURLRequest(path: urlPath) else { return }
        
        Networking.sharedInstance.get(request: request) { (success, object) -> () in
            
            if success {
                
                guard let data = object as? Data else { return }
                
                completion(true, nil, UIImage(data: data))
            } else {
                
                let message = "There was an error"
                DispatchQueue.main.async {
                    completion(false, message, nil)
                }
            }
        }
    }
}
