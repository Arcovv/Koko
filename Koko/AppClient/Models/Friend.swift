//
//  Friend.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import Foundation

enum FriendStatus: Int, Decodable {
    /// status = 0
    case sendInviting
    /// status = 1
    case finished
    /// status = 2
    case inviting
}

struct Friend: Decodable {
    let name: String
    let status: FriendStatus
    let isTop: Bool
    let fId: String
    let updateDate: String
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.status = try container.decode(FriendStatus.self, forKey: .status)
        
        // Handle `isTop` field
        guard let isTop = try? container.decode(String.self, forKey: .isTop) else {
            fatalError("Can't parse isTop field")
        }
        if isTop == "0" {
            self.isTop = false
        } else {
            self.isTop = true
        }
        
        self.fId = try container.decode(String.self, forKey: .fId)
        self.updateDate = try container.decode(String.self, forKey: .updateDate)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case status
        case isTop
        case fId = "fid"
        case updateDate
    }
}
