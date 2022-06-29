//
//  AlbumController.swift
//  Albums
//
//  Created by Waseem Idelbi on 6/28/22.
//

import Foundation

class AlbumController {
    
//MARK: - Properties -
    
//MARK: - Methods -
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
