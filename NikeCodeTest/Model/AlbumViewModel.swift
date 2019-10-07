//
//  AlbumViewModel.swift
//  NikeCodeTest
//
//  Created by Miguel Perez on 10/3/19.
//  Copyright © 2019 Miguel Perez. All rights reserved.
//

import Foundation
import UIKit

class AlbumViewModel {
    
    var album: Album
    var artworkImg: UIImage?
    var albumGenre: String?
    
    init(album: Album, artworkImg: UIImage? = nil) {
        
        self.album = album
        self.albumGenre = album.genre?[0].name
    }
    
    
    func downloadAlbumImage(completion: @escaping (_ success: Bool) -> ()) {
        
        guard let urlPath = self.album.artworkUrl else { return }
        
        WebServiceManager.sharedInstance.downloadAlbumImage(urlPath: urlPath, completion: { success, message, image in
            
            if success {
                
                self.artworkImg = image
                DispatchQueue.main.async {
                    completion(true)
                }
            }
        })
    }
}
