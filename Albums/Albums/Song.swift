//
//  Song.swift
//  Albums
//
//  Created by Waseem Idelbi on 6/21/22.
//

import Foundation

struct Song: Codable {

//MARK: - Properties -
    var id: String
    var duration: String
    var name: String
    
//MARK: - Coding keys enum
    enum SongKeys: String, CodingKey {
        
        case id
        
        case duration
        enum DurationKey: String, CodingKey {
            case duration
        }
        
        case name
        enum NameKey: String, CodingKey {
            case title
        }
        
    }
    
//MARK: - Decoder & Encoder -
    // Decoder init method
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SongKeys.self)
        let durationContainer = try container.nestedContainer(keyedBy: SongKeys.DurationKey.self, forKey: .duration)
        let nameContainer = try container.nestedContainer(keyedBy: SongKeys.NameKey.self, forKey: .name)

        id = try container.decode(String.self, forKey: .id)
        duration = try durationContainer.decode(String.self, forKey: .duration)
        name = try nameContainer.decode(String.self, forKey: .title)
    }
    
    // Encoder method
    func encode(to encoder: Encoder) throws {
        <#code#>
    }
}
