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
    let baseURL = URL(string: "https://albums-f1003-default-rtdb.firebaseio.com/")!
    var database = Database.database().reference()
    var encoder = JSONEncoder()
    var decoder = JSONDecoder()
    
//MARK: - Methods -
    // Fetch albums - GET
    func getAlbums(completion: @escaping (Error?) -> Void) {
        
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
                let fetchedAlbums = try self.decoder.decode([String : Album].self, from: data)
                for album in fetchedAlbums.values {
                    self.albums.append(album)
                }
                return
            } catch {
                print("ERROR: Could not decode data, error message: \(error)")
                return
            }
            
        }
        .resume()
    }
    // Upload album - PUT
    func put(album: Album) {
        
        var request = URLRequest(url: baseURL.appendingPathComponent(album.id))
        request.httpMethod = "PUT"
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("ERROR: Failed to send album to API, error: \(error)")
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("Album was sent to API successfully!")
                } else {
                    print("ERROR: Failed to send album to API!")
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
            let _ = try JSONDecoder().decode(Album.self, from: data)
            print("SUCCESS!!!")
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
