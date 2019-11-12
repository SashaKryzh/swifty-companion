// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct IntraUser: Decodable {
    let id: Int
    let email, login, firstName, lastName: String?
    let phone: String?
    let displayname: String?
    let imageUrl: String?
    let correctionPoint: Int?

    
    enum CodingKeys: String, CodingKey {
        case id, email, login
        case firstName = "first_name"
        case lastName = "last_name"
        case url, phone, displayname
        case imageURL = "image_url"
        case staff = "staff?"
        case correctionPoint = "correction_point"
        case poolMonth = "pool_month"
        case poolYear = "pool_year"
        case location, wallet, groups
        case cursusUsers = "cursus_users"
        case projectsUsers = "projects_users"
        case languagesUsers = "languages_users"
        case achievements, titles
        case titlesUsers = "titles_users"
        case partnerships, patroned, patroning
        case expertisesUsers = "expertises_users"
        case campus
        case campusUsers = "campus_users"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        login = try container.decodeIfPresent(String.self, forKey: .login)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        firstName =  try container.decodeIfPresent(String.self, forKey: .firstName)
        lastName =  try container.decodeIfPresent(String.self, forKey: .lastName)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
        displayname = try container.decodeIfPresent(String.self, forKey: .displayname)
        correctionPoint = try container.decodeIfPresent(Int.self, forKey: .correctionPoint)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageURL)
    }
    
    var intValue: Int? { return nil }
}

