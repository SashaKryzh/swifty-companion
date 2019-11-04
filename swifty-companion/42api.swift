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
    
    static let baseURL = "https://api.intra.42.fr/v2"
    static let unitFactoryID = 8
    
    static let accessTokenKey = "accessTokenKey" // For local storing
    static var accessToken: String?
    
    static var user: IntraUser?
    
    static func authorize() {
        if let url = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=da438907119c5ef7d7cde41b0690c30e58a8899a67f0cfa31fea31b3c933b62c&redirect_uri=swifty-companion%3A%2F%2Fswifty-companion&response_type=code&scope=public%20profile%20projects%20forum") {
            UIApplication.shared.open(url)
        }
    }
    
    static func signOut() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: accessTokenKey)
        accessToken = nil
        user = nil
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
                if let token = accessToken {
                    saveToken(token: token)
                }
                completition(accessToken)
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    static func aboutMe(completition: @escaping ((IntraUser?) -> Void)) {
        if let user = user {
            completition(user)
        }
        
        guard let token = accessToken else { return }
        
        let url = URL(string: baseURL + "/me")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, url) in
            guard let data = data else { return }
            print("JSON String: \(String(data: data, encoding: .utf8) ?? "")")
            user = try? JSONDecoder().decode(IntraUser.self, from: data)
            DispatchQueue.main.async {
                completition(user)
            }
        })
        task.resume()
    }
    
    static func getUser(userLogin: String, completition: @escaping ((IntraUser?) -> Void)) {
        guard let token = accessToken else { return }
        
        let url = URL(string: baseURL + "/users/\(userLogin.lowercased())")!
        print(url)
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, url) in
            guard let data = data else {
                completition(nil)
                return
            }
            do {
                let user = try JSONDecoder().decode(IntraUser.self, from: data)
                DispatchQueue.main.async {
                    completition(user)
                }
            } catch {
                print(error)
            }
        })
        task.resume()
    }
    
    static func getUsers(page: Int, completition: @escaping (([IntraUser]) -> Void)) {
        guard let token = accessToken else { return }
        
        var comp = URLComponents(string: baseURL + "/users")!
        comp.queryItems = [
            URLQueryItem(name: "page", value: page.description),
//            URLQueryItem(name: "campus_id", value: unitFactoryID.description),
        ]
        
        var request = URLRequest(url: comp.url!)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, url) in
            guard let data = data else { return }
            print("JSON String: \(String(data: data, encoding: .utf8) ?? "")")
            
            do {
                let users = try JSONDecoder().decode([IntraUser].self, from: data)
                DispatchQueue.main.async {
                    completition(users)
                }
            } catch {
                print(error)
            }
        })
        task.resume()
    }
    
    static func saveToken(token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: accessTokenKey)
    }
    
    static func getToken() -> String? {
        let defaults = UserDefaults.standard
        accessToken = defaults.string(forKey: accessTokenKey)
        return accessToken
    }
}
