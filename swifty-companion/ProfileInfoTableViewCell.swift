//
//  ProfileInfoTableViewCell.swift
//  swifty-companion
//
//  Created by Oleksandr KRYZHANOVSKYI on 11/12/19.
//  Copyright © 2019 okryzhan. All rights reserved.
//

import UIKit

class ProfileInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var correctionsLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    func update(user: IntraUser) {
        loginLabel.text = user.login
        displayNameLabel.text = user.displayname
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        correctionsLabel.text = user.correctionPoint?.description ?? "0"
        if let url = URL(string: user.imageUrl ?? "") {
            updateImage(url: url)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
