//
//  ProfileInfoTableViewCell.swift
//  swifty-companion
//
//  Created by Oleksandr KRYZHANOVSKYI on 11/12/19.
//  Copyright © 2019 okryzhan. All rights reserved.
//

import UIKit
import MessageUI

class ProfileInfoTableViewCell: UITableViewCell, MFMailComposeViewControllerDelegate {
    
    weak var vc: UIViewController!
    var user: IntraUser!

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var correctionsLabel: UILabel!
    @IBOutlet weak var emailLabel: UIButton!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    func update(user: IntraUser) {
        loginLabel.text = user.login
        displayNameLabel.text = user.displayname
        emailLabel.setTitle(user.email, for: .normal)
        phoneLabel.text = user.phone
        correctionsLabel.text = user.correctionPoint?.description ?? "0"
        if let url = URL(string: user.imageUrl ?? "") {
            updateImage(url: url)
        }
        if let cursuses = user.cursusUsers  {
            levelLabel.text = String(format: "%.2f", cursuses[0].level)
        }
    }
    
    func updateImage(url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async() {
                self.profileImageView.image = image
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func emailPressed(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["\(user.email ?? "")"])
            mail.setMessageBody("<p>Hello, \(user.login ?? "")!</p>", isHTML: true)
            vc?.present(mail, animated: true)
        } else {
            print("Unable to send email")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
