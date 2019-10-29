//
//  ProfileViewController.swift
//  swifty-companion
//
//  Created by Oleksandr KRYZHANOVSKYI on 10/22/19.
//  Copyright © 2019 okryzhan. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    var userId: Int?
    var user: IntraUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let userId = userId {
            print(userId)
        } else {
//            getAboutMe()
            getUser(userLogin: "okryzhan")
        }
    }
    
    func getAboutMe() {
        IntraApi.aboutMe(completition: { user in
            self.user = user
            guard let user = self.user else {
                print("User is empty")
                return
            }
            print(user)
        })
    }
    
    func getUser(userLogin: String) {
        IntraApi.getUser(userLogin: userLogin, completition: { user in
            self.user = user
            guard let user = self.user else {
                print("User is empty")
                return
            }
            print(user)
        })
    }
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        IntraApi.signOut()
        let appDelegate =  UIApplication.shared.delegate as? AppDelegate
        appDelegate?.popToSignIn()
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
