//
//  DetailCell.swift
//  HookahJam
//
//  Created by Ihor Kovalenko on 3/23/20.
//  Copyright © 2020 Ihor Kovalenko. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    @IBOutlet weak var siteLogo: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var siteName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
