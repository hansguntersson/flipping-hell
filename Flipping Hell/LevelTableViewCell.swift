//
//  LevelTableViewCell.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 11/10/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

class LevelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var levelStars: UILabel!
    @IBOutlet weak var levelIndex: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
