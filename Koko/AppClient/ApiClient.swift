//
//  ApiClient.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import Foundation
import RxSwift

final class ApiClient {
    var getCurrentUser: () -> Observable<User>
    var getFriends: () -> Observable<[Friend]>
    
    init(
        getCurrentUser: @escaping () -> Observable<User>,
        getFriends: @escaping () -> Observable<[Friend]>
    ) {
        self.getCurrentUser = getCurrentUser
        self.getFriends = getFriends
    }
}
