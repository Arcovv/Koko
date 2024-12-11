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
