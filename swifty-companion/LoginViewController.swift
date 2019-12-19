//
//  LoginViewController.swift
//  swifty-companion
//
//  Created by Oleksandr KRYZHANOVSKYI on 10/22/19.
//  Copyright © 2019 okryzhan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        IntraApi.checkToken() { _ in
            self.navigationController?.performSegue(withIdentifier: "toSearchVC", sender: self)
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        IntraApi.authorize()
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
