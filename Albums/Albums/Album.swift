//
//  Album.swift
//  Albums
//
//  Created by Waseem Idelbi on 6/21/22.
//

import Foundation

struct Album: Decodable {

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
        
        case coverArt
        enum CoverArtKeys: String, CodingKey {
            case url
        }
        
        case songs
        
    }
    
//MARK: - Decoder init method -
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AlbumKeys.self)
        var genresContainer = try container.nestedUnkeyedContainer(forKey: .genres)
        var coverArtArrayContainer = try container.nestedUnkeyedContainer(forKey: .coverArt)
        var songsArrayContainer = try container.nestedUnkeyedContainer(forKey: .songs)
        
        name = try container.decode(String.self, forKey: .name)
        artist = try container.decode(String.self, forKey: .artist)
        id = try container.decode(String.self, forKey: .id)
        
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
        
        songs = []
        while !songsArrayContainer.isAtEnd {
            let songContainer = try songsArrayContainer.nestedContainer(keyedBy: Song.SongKeys.self)
            let newSong = try Song(from: decoder)
        }
        
    }
    
}
