//
//  FindTableViewController.swift
//  swifty-companion
//
//  Created by Oleksandr KRYZHANOVSKYI on 10/22/19.
//  Copyright © 2019 okryzhan. All rights reserved.
//

import UIKit

class FindTableViewController: UITableViewController {

    var page = 1
    
    var users: [IntraUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Seting up a SearchController
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search 42 login"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        updateUsers()
    }
    
    func updateUsers() {
        IntraApi.getUsers(page: page, completition: { users in
            self.users = users
            self.tableView.reloadData()
        })
    }
    
    var loginToSearch: String?
    func searchForUser() {
        guard let login = loginToSearch else { return }
        IntraApi.getUser(userLogin: login, completition: {
            user in
            if let user = user {
                
            }
        })
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        searchForUser()
//        return false
//    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)

        cell.textLabel?.text = users[indexPath.row].login

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FindTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        loginToSearch = searchController.searchBar.text!
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchForUser()
    }
}
