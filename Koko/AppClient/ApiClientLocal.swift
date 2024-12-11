//
//  ApiClientLocal.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import Foundation
import RxSwift

extension ApiClient {
    static let apiClientLocal = ApiClient(
        getCurrentUser: {
            let user: User = loadModel(fileName: "user")
            return Observable.just(user)
        },
        getFriends: {
            let friends: [Friend]
            
            switch AppDependency.current.apiClientStrategy {
            case .emptyFriends:
                friends = ApiClientStrategy.getEmptyFriends()
                
            case .mixedFriends:
                friends = ApiClientStrategy.getMixedFriends()
                
            case .friendsWithInviting:
                friends = ApiClientStrategy.getFriendsWithInviting()
            }
            
            return Observable.just(friends)
        }
    )
}

fileprivate extension ApiClientStrategy {
    static func getEmptyFriends() -> [Friend] {
        return loadModels(fileName: "friends4")
    }
    
    static func getMixedFriends() -> [Friend] {
        let friends1: [Friend] = loadModels(fileName: "friends1")
        let friends2: [Friend] = loadModels(fileName: "friends2")
        return friends1 + friends2
    }
    
    static func getFriendsWithInviting() -> [Friend] {
        return loadModels(fileName: "friends3")
    }
}

fileprivate func loadModel<T: Decodable>(fileName: String) -> T {
    let url = Bundle.main.url(forResource: fileName, withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let result = try! JSONDecoder().decode(AppResponse<T>.self, from: data)
    
    return result.response
}

fileprivate func loadModels<T: Decodable>(fileName: String) -> [T] {
    let url = Bundle.main.url(forResource: fileName, withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let result = try! JSONDecoder().decode(AppResponse<[T]>.self, from: data)
    
    return result.response
}
