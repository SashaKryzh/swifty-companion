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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        IntraApi.authorize()
//        performSegue(withIdentifier: "toMainVC", sender: nil)
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
