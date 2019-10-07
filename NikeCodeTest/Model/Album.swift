//
//  Album.swift
//  NikeCodeTest
//
//  Created by Miguel Perez on 10/3/19.
//  Copyright © 2019 Miguel Perez. All rights reserved.
//

import Foundation

struct Album: Codable {
    
    var id: String?
    var name: String?
    var copyright: String?
    var artistName: String?
    var artworkUrl: String?
    var genre: [Genre]?
    var releaseDate: String?
    var url: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, copyright, artistName, artworkUrl = "artworkUrl100", genre = "genres", releaseDate, url
    }
}


struct Genre: Codable {
    
    var genreId: String
    var name: String
    var url: String
}
