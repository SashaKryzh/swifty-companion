//
//  FindTableViewController.swift
//  swifty-companion
//
//  Created by Oleksandr KRYZHANOVSKYI on 10/22/19.
//  Copyright © 2019 okryzhan. All rights reserved.
//

import UIKit

class FindTableViewController: UITableViewController, UITableViewDataSourcePrefetching {

    var page = 1
    
    var users: [IntraUser] = []
    
    var selectedUser: IntraUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchController()
        
        tableView.prefetchDataSource = self
        
        IntraApi.checkToken() { _ in
            self.updateUsers()
        }
    
        self.navigationItem.hidesSearchBarWhenScrolling = true;
        self.navigationItem.hidesBackButton = true;
    }
    
    func setSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search 42 login"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateUsers() {
        IntraApi.getUsers(page: page) { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    var loginToSearch: String?
    func searchForUser() {
        guard let login = loginToSearch else { return }
        loginToSearch = nil
        IntraApi.getUser(userLogin: login, completition: {
            user in
            if let user = user {
                self.selectedUser = user
                self.performSegue(withIdentifier: "toDetailUser", sender: self)
                self.navigationItem.searchController?.searchBar.text = nil
            }
        }, err: {
            error in
            self.displayAlert(text: error)
        })
    }
    
    func displayAlert(text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        searchForUser()
//        return false
//    }

    func addUsers() {
        page += 1
        IntraApi.getUsers(page: page) { users in
            self.users += users
        }
    }
    
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
        
        loginToSearch = users[indexPath.row].login
        IntraApi.checkToken() { _ in
            self.searchForUser()
        }
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }

    @IBAction func signOutPressed(_ sender: Any) {
        IntraApi.signOut()
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.popToSignIn()
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailUser" {
            guard let user = selectedUser else { return }
            let vc = segue.destination as! DetailTableViewController
            vc.user = user
        }
    }

}

extension FindTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        loginToSearch = searchController.searchBar.text!
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        IntraApi.checkToken() { _ in
            self.searchForUser()
        }
    }
}
