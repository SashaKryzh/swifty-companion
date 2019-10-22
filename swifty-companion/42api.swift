//
//  42api.swift
//  swifty-companion
//
//  Created by Oleksandr KRYZHANOVSKYI on 10/22/19.
//  Copyright © 2019 okryzhan. All rights reserved.
//

import UIKit

class IntraApi {
    static let uid = "da438907119c5ef7d7cde41b0690c30e58a8899a67f0cfa31fea31b3c933b62c"
    static let secret = "de1fdafbbe018cbf435e735ebefb52620cabaa5a2ba5349cc681f8dee4d95c16"
    
    func signIn() {
//        var components = URLComponents(string: "https://api.intra.42.fr/oauth/authorize")
//        components?.queryItems = [
//            URLQueryItem(name: "client_id", value: IntraApi.uid)
//        ]
//        if let url = components?.url {
//            UIApplication.shared.open(url)
//        }
        if let url = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=da438907119c5ef7d7cde41b0690c30e58a8899a67f0cfa31fea31b3c933b62c&redirect_uri=com.okryzhan.swift-companion%3A%2F%2FloginScheme&response_type=code") {
            UIApplication.shared.open(url)
        }
    }
}
