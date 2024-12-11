//
//  AppDependency.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import Foundation

enum ApiClientStrategy {
    case emptyFriends
    case mixedFriends
    case friendsWithInviting
}

final class AppDependency {
    static let shared = AppDependency()
    
    let apiClient = ApiClient.apiClientLocal
    var apiClientStrategy: ApiClientStrategy = .friendsWithInviting
}
