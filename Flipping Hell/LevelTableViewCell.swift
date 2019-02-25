//
//  LevelTableViewCell.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 11/10/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

protocol SelectLevel {
    func selectLevelFromButton(LevelSelected: Int)
}

class LevelTableViewCell: UITableViewCell {
    
    @IBOutlet var levelIndex: UIButton!
    @IBOutlet var levelGoal: UILabel!
    @IBOutlet var levelStars: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func clickLevelButton(_ sender: UIButton) {
        print("clicked")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
