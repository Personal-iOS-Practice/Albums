//
//  Album.swift
//  Albums
//
//  Created by Waseem Idelbi on 6/21/22.
//

import Foundation

//MARK: - Main Struct -
struct Album {
    var name: String
    var artist: String
    var id: String
    var genres: [String]
    var coverArt: [ImageStringURL]
    var songs: [Song]
}

//MARK: - Helper Structs -

// Main image url struct
struct ImageStringURL {
    var url: String
}

// Main Song struct
struct Song {
    var id: String
    var name: Name
    var duration: Duration
}
/// Song's helper struct
struct Name {
    var title: String
}
/// Song's helper struct
struct Duration {
    var duration: String
}
