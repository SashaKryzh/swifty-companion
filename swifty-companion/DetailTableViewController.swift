//
//  DetailTableViewController.swift
//  swifty-companion
//
//  Created by Oleksandr KRYZHANOVSKYI on 11/4/19.
//  Copyright © 2019 okryzhan. All rights reserved.
//

import UIKit

enum DetailPageSections: Int {
    case main = 0,
    skills,
    project
}

class DetailTableViewController: UITableViewController {

    var user: IntraUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = user.login
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case DetailPageSections.main.rawValue:
            return 1
        case DetailPageSections.skills.rawValue:
            return user.cursusUsers?.first?.skills.count ?? 0
        case DetailPageSections.project.rawValue:
            return user.finishedProjects?.count ?? 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        
        if section == DetailPageSections.skills.rawValue {
            title = "Skills"
        }
        if section == DetailPageSections.project.rawValue {
            title = "Projects"
        }
        
        return title
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == DetailPageSections.main.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! ProfileInfoTableViewCell
            
            cell.user = user
            cell.vc = self
            cell.update(user: user)
            
            return cell
        } else if indexPath.section == DetailPageSections.skills.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell", for: indexPath)
            
            let skill = user.cursusUsers![0].skills[indexPath.row]
            cell.textLabel?.text = skill.name + " (" + skill.persantage.description + ")"
            cell.detailTextLabel?.text = String(format: "%.2f", skill.level)
            
            return cell
        } else if indexPath.section == DetailPageSections.project.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
            
            let project = user.finishedProjects![indexPath.row]
            cell.textLabel?.text = project.project.name
            cell.detailTextLabel?.text = project.finalMark?.description
            cell.detailTextLabel?.textColor = project.validated ?? true ? UIColor.green : UIColor.red
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Error...", for: indexPath)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
