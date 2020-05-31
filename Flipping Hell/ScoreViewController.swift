//
//  ScoreViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 19/05/2020.
//  Copyright © 2020 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

// ********************************** PROTOCOLS ********************************** //

protocol UpdateModelScoresDelegate: class {
    func requestScores()
}
    

// ********************************** CLASS DEFINITION ********************************** //

class ScoreViewController: UIViewController {
    
    weak var game: FlippingHell?
    
    // ********************************** DELEGATES ********************************** //
    
    weak var UpdateModelScoresDelegateInstance: UpdateModelScoresDelegate!
    
    
     // ********************************** OUTLETS ********************************** //

    @IBOutlet weak var GoldStars: UILabel!
    @IBOutlet weak var SilverStars: UILabel!
    @IBOutlet weak var BronzeStars: UILabel!
    @IBOutlet weak var TotalStars: UILabel!
    @IBOutlet weak var StarsToNextStage: UILabel!
    
    
     // ********************************** LOAD FUNCTION ********************************** //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UpdateModelScoresDelegateInstance = game
        UpdateModelScoresDelegateInstance.requestScores()
        
        // Do any additional setup after loading the view.
    }
}

// ********************************** EXTENSIONS ********************************** //

extension ScoreViewController: UpdateScoreViewDelegate { // Receives and processes level list
    func receiveScores(GoldStars: Int, SilverStars: Int, BronzeStars: Int, TotalStars: Int, RemainingStars: Int) {
        self.GoldStars.text = "\(GoldStars)"
        self.SilverStars.text = "\(SilverStars)"
        self.BronzeStars.text = "\(BronzeStars)"
        self.TotalStars.text = "\(TotalStars)"
        self.StarsToNextStage.text = "Stars required to unlock next stage: \(RemainingStars)"
    }
}
