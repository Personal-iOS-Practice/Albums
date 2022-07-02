//
//  AlbumController.swift
//  Albums
//
//  Created by Waseem Idelbi on 6/28/22.
//

import Foundation
import FirebaseDatabase

class AlbumController {
    
//MARK: - Properties -
    var albums: [Album] = []
    let baseURL = URL(string: "https://albums-f1003-default-rtdb.firebaseio.com/.json")!
    var database = Database.database().reference()
    var encoder = JSONEncoder()
    var decoder = JSONDecoder()
    
//MARK: - Methods -
    // Creates a new Album, adds it to the albums array, and sends it to the API
    func createAlbum(name: String, artist: String, id: String, genres: [String], coverArt: [URL], songs: [Song]) {
        let newAlbum = Album(name: name, artist: artist, id: id, genres: genres, coverArt: coverArt, songs: songs)
        put(album: newAlbum)
    }
    // Updates an Album instance and sends changes to the API
    func update(album: inout Album, name: String, artist: String, id: String, genres: [String], coverArt: [URL], songs: [Song]) {
        album.name = name
        album.artist = artist
        album.id = id
        album.genres = genres
        album.coverArt = coverArt
        album.songs = songs
        put(album: album)
    }
    // Initializes a new Song instance and returns it
    func createSong(id: String, duration: String, name: String) -> Song {
        return Song(id: id, duration: duration, name: name)
    }
    // Fetch albums - GET
    func getAlbums(completion: @escaping (Error?) -> Void) {
        
//        database.root.getData { error, snapshot in
//            if let error = error {
//                print("ERROR: The built in firebase crap didn't work :/ | error: \(error)")
//                completion(error)
//                return
//            }
//
//            let fetchedAlbums = snapshot?.value as! [String : Album]
//            for album in fetchedAlbums.values {
//                self.albums.append(album)
//            }
//        }
        
        URLSession.shared.dataTask(with: baseURL) { data, response, error in
            if let error = error {
                completion(error)
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("ERROR: Fetching albums failed")
                }
            }
            guard let data = data else { return }

            do {
                let fetchedAlbumsDictionary = try self.decoder.decode([String : Album].self, from: data)
                var fetchedAlbums: [Album] = []
                
                for album in fetchedAlbumsDictionary.values {
                    fetchedAlbums.append(album)
                }
                
                self.albums = fetchedAlbums
                completion(nil)
                return
                
            } catch {
                print("ERROR: Could not decode data, error message: \(error)")
                completion(error)
                return
            }

        } .resume()
    }
    // Upload album - PUT
    func put(album: Album) {
        
        var request = URLRequest(url: baseURL.appendingPathComponent(album.id).appendingPathExtension("json"))
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        
        do {
            let data = try encoder.encode(album)
            request.httpBody = data
        } catch {
            print("ERROR: Could not encode album into data, error: \(error)")
            return
        }
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("ERROR: Failed to send album to API, error: \(error)")
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("Album was sent to API successfully, code: \(response.statusCode)")
                } else {
                    print("ERROR: Failed to send album to API, code: \(response.statusCode)")
                    return
                }
            }
        }
        .resume()
        
    }
    
    // Test encoding and decoding methods
    func testDecodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        
        do {
            let data = try Data(contentsOf: urlPath)
            var album = try JSONDecoder().decode(Album.self, from: data)
            album.id = UUID().uuidString
            
            put(album: album)
        } catch {
            print("ERROR: Could not create album from json data, error: \(error)")
        }
        
    }
    
    func testEncodingExampleAlbum() {
        let urlPath = Bundle.main.url(forResource: "exampleAlbum", withExtension: "json")!
        
        do {
            let data = try Data(contentsOf: urlPath)
            let newAlbum = try JSONDecoder().decode(Album.self, from: data)
            print("DECODING SUCCESS!!!")
            let _ = try JSONEncoder().encode(newAlbum)
            print("ENCODING SUCCESS!!!")
        } catch {
            print("ENCODING FAILED, error: \(error)")
        }
        
    }
    
}
