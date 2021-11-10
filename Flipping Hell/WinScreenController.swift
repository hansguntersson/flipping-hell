//
//  WinScreenController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 12/11/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

// ********************************** PROTOCOLS ********************************** //

protocol ReplayLevelDelegate: AnyObject {
    func replayLevel()
}

protocol UpdateModelWinDelegate: AnyObject {
    func nextLevel()
    func requestWin()
}

import UIKit
import AVFoundation

// ********************************** CLASS DEFINITION ********************************** //

class WinScreenController: UIViewController {
    
    weak var game: FlippingHell?
    
    var WinFlips: Int16 = 0
    var GoalFlips: Int16 = 0
    var LevelNumber: Int = 0
    var StageNumber: Int = 0
    var StageMax: Int = 2
    var newStage: Bool = false
    
    var levels: [Level] = []
   
    @IBOutlet var NextLevelButton: UIRoundedButton!
    @IBOutlet var NextLevelText: UILabel!
    @IBOutlet var WinStarsText: UILabel!
    @IBOutlet var WinFlipsText: UILabel!
    @IBOutlet var GoalFlipsText: UILabel!

    @IBOutlet weak var WinStarBoxOuter: UIView!
    @IBOutlet weak var WinStarBoxInner: UIView!
    @IBOutlet weak var NewStageView: UIView!
    
    var WinStarsString: String = ""
    var WinStarColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    // ********************************** SOUNDS ********************************** //
    
    let swooshsoundurl = URL(fileURLWithPath: Bundle.main.path(forResource: "swoosh.mp3", ofType: nil)!)
    let winsoundurl = URL(fileURLWithPath: Bundle.main.path(forResource: "success.wav", ofType: nil)!)
    let pagesoundurl = URL(fileURLWithPath: Bundle.main.path(forResource: "pageturn.mp3", ofType: nil)!)

    
    // ********************************** DELEGATES ********************************** //
    
    weak var ReplayButtonsDelegateInstance: ReplayLevelDelegate!
    weak var UpdateModelWinDelegateInstance: UpdateModelWinDelegate!
    
    // ********************************** FUNCTIONS ********************************** //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UpdateModelWinDelegateInstance = game
        game?.requestWin()
        
        GoalFlipsText.text = "GOAL: \(GoalFlips)"
        WinFlipsText.text = "FLIPS: \(WinFlips)"
        
        if (WinFlips - GoalFlips > 2) {
            WinStarsText.text = "★"
            WinStarsText.textColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
            WinStarBoxOuter.backgroundColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
            WinStarBoxInner.backgroundColor = #colorLiteral(red: 1, green: 0.8517647059, blue: 0.65, alpha: 1)
            self.winSound(Stars: 1)
        } else if (WinFlips - GoalFlips > 0) {
            WinStarsText.text = "★ ★"
            WinStarsText.textColor = #colorLiteral(red: 0.712579906, green: 0.712579906, blue: 0.712579906, alpha: 1)
            WinStarBoxOuter.backgroundColor = #colorLiteral(red: 0.712579906, green: 0.712579906, blue: 0.712579906, alpha: 1)
            WinStarBoxInner.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
            self.winSound(Stars: 2)
        } else if (WinFlips - GoalFlips <= 0) {
            WinStarsText.text = "★ ★ ★"
            WinStarsText.textColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
            WinStarBoxOuter.backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
            WinStarBoxInner.backgroundColor = #colorLiteral(red: 1, green: 0.94, blue: 0.7, alpha: 1)
            self.winSound(Stars: 3)
        }
        
        
        // New stage or level button defined by current stage etc
        if (StageNumber == (StageMax - 1) && LevelNumber == 19) {
            NextLevelText.isHidden = true
            NextLevelButton.isHidden = true
        } else if (LevelNumber == 19) {
            NextLevelText.text = "Next Stage"
        } else {
            NextLevelText.text = "Next Level"
        }
        
        // Show or hide new stage unlocked
        if (newStage == false) { // TODO: Fix this
            NewStageView.isHidden = true
        } else {
            NewStageView.isHidden = false
        }
        
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
    
    @IBAction func replayLevel(_ sender: UIButton) {
        ReplayButtonsDelegateInstance.replayLevel()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextLevel(_ sender: UIButton) {
        UpdateModelWinDelegateInstance.nextLevel()
        ReplayButtonsDelegateInstance.replayLevel()
        self.dismiss(animated: true, completion: nil)
    }
    
    func winSound (Stars: Int) { // Play sound when level is won
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: winsoundurl)
            audioPlayer?.volume = 0.5
            audioPlayer?.play()
        } catch {
            print("Unable to locate audio file")
        }
        
        if (Stars >= 1) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: self.winsoundurl)
                audioPlayer?.volume = 0.5
                audioPlayer?.play()
            } catch {
                print("Unable to locate audio file")
            }
        }
        
        if (Stars >= 2) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: winsoundurl)
                audioPlayer?.volume = 0.5
                audioPlayer?.play()
            } catch {
                print("Unable to locate audio file")
            }
        }
        
        if (Stars == 3) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: winsoundurl)
                audioPlayer?.volume = 0.5
                audioPlayer?.play()
            } catch {
                print("Unable to locate audio file")
            }
        }
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

extension WinScreenController: UpdateWinViewDelegate { // Updates win view via model
    func receiveWin(GoalFlips: Int16, LevelID: Int, StageID: Int, StageMax: Int, NewStage: Bool) {
        self.GoalFlips = GoalFlips
        self.LevelNumber = LevelID
        self.StageNumber = StageID
        self.StageMax = StageMax
        self.newStage = NewStage
    }
}
