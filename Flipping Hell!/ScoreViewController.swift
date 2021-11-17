//
//  ScoreViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 19/05/2020.
//  Copyright © 2020 Hans Guntersson Ltd. All rights reserved.
//

import UIKit
import AVFoundation

// ********************************** PROTOCOLS ********************************** //

protocol UpdateModelScoresDelegate: AnyObject {
    func requestScores()
}

// ********************************** CLASS DEFINITION ********************************** //

class ScoreViewController: UIViewController {
    
    weak var game: FlippingHell?
    
    // ********************************** SOUNDS ********************************** //

    let swooshsoundurl = URL(fileURLWithPath: Bundle.main.path(forResource: "swoosh.mp3", ofType: nil)!)

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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: self.swooshsoundurl)
                audioPlayer?.volume = 1
                audioPlayer?.play()
            } catch {
                print("Unable to locate audio file")
            }
        }
    }
}

// ********************************** EXTENSIONS ********************************** //

extension ScoreViewController: UpdateScoreViewDelegate { // Receives and processes level list
    func receiveScores(GoldStars: Int, SilverStars: Int, BronzeStars: Int, TotalStars: Int, RemainingStars: Int) {
        self.GoldStars.text = "\(GoldStars)"
        self.SilverStars.text = "\(SilverStars)"
        self.BronzeStars.text = "\(BronzeStars)"
        self.TotalStars.text = "\(TotalStars)"
        self.StarsToNextStage.text = "★ \(RemainingStars)"
    }
}

