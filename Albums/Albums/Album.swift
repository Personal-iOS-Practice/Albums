//
//  Album.swift
//  Albums
//
//  Created by Waseem Idelbi on 6/21/22.
//

import Foundation

struct Album: Codable {

//MARK: - Properties -
    var name: String
    var artist: String
    var id: String
    var genres: [String]
    var coverArt: [URL]
    var songs: [Song]
    
//MARK: - Coding keys enum
    enum AlbumKeys: String, CodingKey {
        
        case name
        case artist
        case id
        case genres
        case songs
        
        case coverArt
        enum CoverArtKeys: String, CodingKey {
            case url
        }
        
    }
    
//MARK: - Decoder & Encoder -
    // Decoder init method
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var coverArtArrayContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        id = try container.decode(String.self, forKey: .id)
        songs = try container.decode([Song].self, forKey: .songs)
        
        genres = []
        while !genresContainer.isAtEnd {
            let genreString = try genresContainer.decode(String.self)
            genres.append(genreString)
        }
        
        coverArt = []
        while !coverArtArrayContainer.isAtEnd {
            let coverArtContainer = try coverArtArrayContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            let url = try coverArtContainer.decode(URL.self, forKey: .url)
            coverArt.append(url)
        }
        
    }
    
    // Encoder method
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: AlbumKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(artist, forKey: .artist)
        try container.encode(id, forKey: .id)
        try container.encode(genres, forKey: .genres)
        try container.encode(songs, forKey: .songs)
        
        var coverArtArrayContainer = container.nestedUnkeyedContainer(forKey: .coverArt)
        for url in coverArt {
            var coverArtContainer = coverArtArrayContainer.nestedContainer(keyedBy: AlbumKeys.CoverArtKeys.self)
            try coverArtContainer.encode(url, forKey: .url)
        }
        
    }
    
}
