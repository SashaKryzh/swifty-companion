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
    
    static var accessToken: String?
    
    static func authorize() {
        if let url = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=da438907119c5ef7d7cde41b0690c30e58a8899a67f0cfa31fea31b3c933b62c&redirect_uri=swifty-companion%3A%2F%2Fswifty-companion&response_type=code") {
            UIApplication.shared.open(url)
        }
    }
    
    static func codeToToken(code: String, completition: @escaping (_ accessToken: String?) -> Void) {
        guard var comp = URLComponents(string: "https://api.intra.42.fr/oauth/token") else {
            completition(nil)
            return
        }
        
        let queryItems = [
            URLQueryItem(name: "grant_type", value: "client_credentials"),
            URLQueryItem(name: "client_id", value: uid),
            URLQueryItem(name: "client_secret", value: secret),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: "swifty-companion%3A%2F%2Fswifty-companion"),
        ]
        comp.queryItems = queryItems
        
        var request = URLRequest(url: comp.url!)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print("Data is nil")
                completition(nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, Any>
                print(json)
                accessToken = json["access_token"] as? String
                completition(accessToken)
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
