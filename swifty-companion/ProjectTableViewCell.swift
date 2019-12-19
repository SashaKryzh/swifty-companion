//
//  ProjectTableViewCell.swift
//  swifty-companion
//
//  Created by Oleksandr KRYZHANOVSKYI on 12/19/19.
//  Copyright © 2019 okryzhan. All rights reserved.
//

import UIKit
import MarqueeLabel

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var Title: MarqueeLabel!
    @IBOutlet weak var Detail: UILabel!
    
    func update(title: String, detail: String, color: UIColor)
    {
        Title.text = title
        Detail.text = detail
        Detail.textColor = color
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellInit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        cellInit()
    }
    
    func cellInit(){
        self.Title.type = .continuous
        self.Title.trailingBuffer = 5
    }

}
