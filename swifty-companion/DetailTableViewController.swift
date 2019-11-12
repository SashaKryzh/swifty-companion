//
//  DetailTableViewController.swift
//  swifty-companion
//
//  Created by Oleksandr KRYZHANOVSKYI on 11/4/19.
//  Copyright © 2019 okryzhan. All rights reserved.
//

import UIKit

enum DetailPageSections: Int {
    case main = 0
}

class DetailTableViewController: UITableViewController {

    var user: IntraUser?
    
    @IBOutlet weak var loginLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case DetailPageSections.main.rawValue:
            return 1
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == DetailPageSections.main.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! ProfileInfoTableViewCell
            
            cell.update(user: user!)
            
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
