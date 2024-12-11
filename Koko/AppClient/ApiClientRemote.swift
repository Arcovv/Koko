//
//  ApiClientRemote.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/12.
//

import Foundation
import RxSwift
import RxCocoa

extension ApiClient {
    static let jsonDecoder = JSONDecoder()
    
    static let apiClientRemote = ApiClient(
        getCurrentUser: {
            return getResponse(url: "https://dimanyen.github.io/man.json")
        },
        getFriends: {
            let friendsObservable: Observable<[Friend]>
            
            switch AppDependency.current.apiClientStrategy {
            case .emptyFriends:
                friendsObservable = getResponses(url: "https://dimanyen.github.io/friend4.json")
                
            case .mixedFriends:
                let friends1: Observable<[Friend]> = getResponses(url: "https://dimanyen.github.io/friend1.json")
                let friends2: Observable<[Friend]> = getResponses(url: "https://dimanyen.github.io/friend2.json")
                friendsObservable = Observable.zip(friends1, friends2) { $0 + $1 }
                
            case .friendsWithInviting:
                friendsObservable = getResponses(url: "https://dimanyen.github.io/friend3.json")
            }
            
            return friendsObservable
        }
    )
    
    private static func getResponse<T>(url: String) -> Observable<T> where T: Decodable {
        let url = URL(string: url)!
        let request = URLRequest(url: url)
        return URLSession.shared.rx.data(request: request)
            .map { try jsonDecoder.decode(AppResponse<T>.self, from: $0) }
            .map { $0.response }
    }
    
    private static func getResponses<T>(url: String) -> Observable<[T]> where T: Decodable {
        let url = URL(string: url)!
        let request = URLRequest(url: url)
        return URLSession.shared.rx.data(request: request)
            .map { try jsonDecoder.decode(AppResponse<[T]>.self, from: $0) }
            .map { $0.response }
    }
}
