//
//  User.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import Foundation

struct User: Decodable {
    let name: String
    let kokoId: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case kokoId = "kokoid"
    }
}
