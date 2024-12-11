//
//  FriendsSection.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/11.
//

import Foundation
import RxDataSources

extension Friend: IdentifiableType {
    typealias Identity = String
    
    var identity: String {
        return self.fId
    }
}

extension Friend: Equatable {
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.fId == rhs.fId
    }
}

extension Friend: Comparable {
    static func < (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.updateDate < rhs.updateDate
    }
}

struct FriendsSection {
    var items: [Friend]
    
    init(items: [Friend]) {
        self.items = items
    }
}

extension FriendsSection: AnimatableSectionModelType {
    typealias Identity = String
    typealias Item = Friend
    
    var identity: String { return "" }
    
    init(original: FriendsSection, items: [Friend]) {
        self = original
        self.items = items
    }
}
