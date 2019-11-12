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
    let cursusUsers: [CursusUsers]?
    let projectsUsers: [ProjectUsers]?
    
    var finishedProjects: [ProjectUsers]? {
        guard let projects = projectsUsers else { return nil }
        return projects.filter { project in
            return ((project.status == "finished" || project.validated == false) && project.project.parentID == nil && project.cursusIDs.contains(1))
        }
    }
    
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
        cursusUsers = try container.decodeIfPresent([CursusUsers].self, forKey: .cursusUsers)
        projectsUsers = try container.decodeIfPresent([ProjectUsers].self, forKey: .projectsUsers)
    }
    
    var intValue: Int? { return nil }
}

struct CursusUsers: Decodable {
    let level: Double
    let skills: [Skill]
    
    enum CodingKeys: String, CodingKey {
        case level, skills
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        level = try container.decode(Double.self, forKey: .level)
        skills = try container.decode([Skill].self, forKey: .skills)
    }
}

struct Skill: Decodable {
    let name: String
    let level: Double
    
    var persantage: String {
        let p = level / 20
        return String(format: "%.2f", p) + "%"
    }
    
    enum CodingKeys: String, CodingKey {
        case name, level
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        level = try container.decode(Double.self, forKey: .level)
    }
}

struct ProjectUsers: Decodable {
    let finalMark: Int?
    let status: String
    let project: Project
    let validated: Bool?
    let cursusIDs: [Int]
    
    enum CodingKeys: String, CodingKey {
        case finalMark = "final_mark"
        case status, project
        case validated = "validated?"
        case cursusIDs = "cursus_ids"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        finalMark = try container.decodeIfPresent(Int.self, forKey: .finalMark)
        status = try container.decode(String.self, forKey: .status)
        project = try container.decode(Project.self, forKey: .project)
        validated = try container.decodeIfPresent(Bool.self, forKey: .validated)
        cursusIDs = try container.decode([Int].self, forKey: .cursusIDs)
    }
}

struct Project: Decodable {
    let name: String
    let parentID: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case parentID = "parent_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        parentID = try container.decodeIfPresent(Int.self, forKey: .parentID)
    }
}
