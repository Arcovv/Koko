//
//  AppResponse.swift
//  Koko
//
//  Created by Arco Hsieh on 2024/12/10.
//

import Foundation

struct AppResponse<T: Decodable>: Decodable {
    let response: T
}
