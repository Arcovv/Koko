//
//  AppDependency.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import Foundation

enum ApiClientStrategy: CaseIterable {
    case emptyFriends
    case mixedFriends
    case friendsWithInviting
    
    var buttonTitle: String {
        switch self {
        case .emptyFriends:
            return "設定為無好友畫面"
        case .mixedFriends:
            return "只有好友列表，同時 Request 兩個資料源"
        case .friendsWithInviting:
            return "好友列表含邀請"
        }
    }
}

final class AppDependency {
    static var current = AppDependency()
    
    var apiClient: ApiClient
    var apiClientStrategy: ApiClientStrategy
    
    init(
        apiClient: ApiClient = .apiClientLocal,
        apiClientStrategy: ApiClientStrategy = .friendsWithInviting
    ) {
        self.apiClient = apiClient
        self.apiClientStrategy = apiClientStrategy
    }
}
