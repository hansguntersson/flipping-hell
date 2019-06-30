//
//  MainViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 20/09/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit
import AVFoundation

// ********************************** PROTOCOLS ********************************** //

protocol UpdateModelDelegate: class {
    func gameWon(LevelID: Int, Flips: Int16, ButtonsClicked: [Int])
    func gameReset()
    func requestLevel()
}

// ********************************** CLASS DEFINITION ********************************** //

class MainViewController: UIViewController {
    
    // ********************************** VARIABLES ********************************** //
    
    weak var game: FlippingHell?
    
    var audioPlayer = AVAudioPlayer()
    
    var FirstOpen: Bool = true // TODO: switch this off when releasing, load from game
    
    var StageNum = 0
    var LevelNum = 0
    
    var GoalFlips: Int16 = 0
    var levelCompleted: Bool = false
    
    var FlipCount: Int16 = 0
    var FlipperOrientation = 0
    
    var buttonStatus = [0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0] // what the current status of the buttons is
    
    var CurrentSequence = [0, 0, 0, 0, 0,
                           0, 0, 0, 0, 0,
                           0, 0, 0, 0, 0,
                           0, 0, 0, 0, 0,
                           0, 0, 0, 0, 0] // Current array sequence loaded
    
    var WinSequence: [Int] = [] // The sequence of moves
    
    let leftValidNums = [1, 2, 3, 4,
                         6, 7, 8, 9,
                         11, 12, 13, 14,
                         16, 17, 18, 19,
                         21, 22, 23, 24] // List to define when left button is flipped
    
    let rightValidNums = [0, 1, 2, 3,
                          5, 6, 7, 8,
                          10, 11, 12, 13,
                          15, 16, 17, 18,
                          20, 21, 22, 23] // List to define when right button is flipped
    
    // ********************************** OUTLETS ********************************** //
    
    
    @IBOutlet var FlipsLabel: UILabel!
    @IBOutlet var levelTitle: UILabel!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var buttonWinCollection: [UIButton]!
    @IBOutlet var buttonFlipperCollection: [UIButton]!
    @IBOutlet var winScreen: UIView!
    
    // ********************************** DELEGATES ********************************** //
    
    weak var UpdateModelDelegateInstance: UpdateModelDelegate!
    
    // ********************************** FUNCTIONS ********************************** //
    
    @IBAction func backToMain(_ sender: UIButton) { // Dismisses view controller back to the title screen
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindFromLevels(segue:UIStoryboardSegue) { // Level selected and unwind
        UpdateModelDelegateInstance.requestLevel()
        resetButtons()
    }
    
    @IBAction func resetLevel(_ sender: UIButton) { //Resets the level from the main screen
        if(FlipCount > 0) { // Only add to attempts if there have been flips made
            // TODO: Ensure that the attempts are increased when a level is won, seems like this is dealt with in the model, make sure it's not done twice
            UpdateModelDelegateInstance.gameReset()
            resetButtons()
        }
    }
    
    override func viewDidLoad() { // Sets up game on load
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        for mainButton in buttonCollection
        {
            // mainButton.layer.cornerRadius = mainButton.frame.size.width / 2.0
            mainButton.cornerCalculation(r: 0.90)
        }
        
        for winButton in buttonWinCollection
        {
            winButton.cornerCalculation(r: 0.90)
        }
        
        for flipButton in buttonFlipperCollection
        {
            flipButton.cornerCalculation(r: 0.90)
        }
        
        UpdateModelDelegateInstance = game
        UpdateModelDelegateInstance.requestLevel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (FirstOpen == true) {
            performSegue(withIdentifier: "GameHelpSegue", sender: nil)
            FirstOpen = false
        }
    }
    
    func resetButtons() { // Resets buttons
        // Reset flip and flipper
        FlipperOrientation = 1 // set to 1 so that the update flipper display moves it back to 0
        updateFlipperDisplay()
        FlipCount = 0
        
        if levelCompleted == false {
            FlipsLabel.text = "FLIPS: \(FlipCount)"
        } else {
            FlipsLabel.text = "FLIPS: \(FlipCount)" +  " / " + "\(GoalFlips)"
        }
        
        
        // Reset buttons and array
        for buttonIndex in 0 ..< buttonStatus.count {
            buttonStatus[buttonIndex] = 0
            buttonCollection[buttonIndex].backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        }
        
        WinSequence = []
    }
    
    @IBAction func clickButton(_ sender: UIButton) { // Flips buttons based on the button clicked
        let button = sender
        var WinVal = false
        
        let idNum: Int = Int(button.accessibilityIdentifier ?? "0") ?? 0
        WinSequence.append(idNum)
        
        flipButton(button, buttonIndex: idNum)

        if (FlipperOrientation == 0) {
            if (leftValidNums.contains(idNum)) {
                let idNumLeft = idNum - 1
                let buttonLeft = buttonCollection[idNumLeft]
                flipButton(buttonLeft, buttonIndex: idNumLeft)
            }
            if (rightValidNums.contains(idNum)) {
                let idNumRight = idNum + 1
                let buttonRight = buttonCollection[idNumRight]
                flipButton(buttonRight, buttonIndex: idNumRight)
            }
        } else {
            if (idNum > 4) {
                let idNumTop = idNum - 5
                let buttonTop = buttonCollection[idNumTop]
                flipButton(buttonTop, buttonIndex: idNumTop)
            }
            if (idNum < 20) {
                let idNumBottom = idNum + 5
                let buttonBottom = buttonCollection[idNumBottom]
                flipButton(buttonBottom, buttonIndex: idNumBottom)
            }
        }
        updateFlipperDisplay()
        FlipCount += 1
        
        
        if levelCompleted == false {
            FlipsLabel.text = "FLIPS: \(FlipCount)"
        } else {
            FlipsLabel.text = "FLIPS: \(FlipCount)" +  " / " + "\(GoalFlips)"
        }
        
        WinVal = checkWin()
        
        if (WinVal == true) {
            UpdateModelDelegateInstance.gameWon(LevelID: LevelNum, Flips: FlipCount, ButtonsClicked: WinSequence)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.performSegue(withIdentifier: "GameWonSegue", sender: self)
            }
        }
    }
    
    func flipButton(_ sender: UIButton, buttonIndex: Int) { // Flips the corresponding button
        let button = sender
        
        let widthVal = button.frame.size.width
        let animTime = 0.2
        let xVal = button.center.x
        let yVal = button.center.y
        var baseColour = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        
        let buttonState = buttonStatus[buttonIndex]
        
        if (buttonState == 0) {
            baseColour = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
            buttonStatus[buttonIndex] = 1
        } else {
            baseColour = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
            buttonStatus[buttonIndex] = 0
        }
        
        if (FlipperOrientation == 0) {
            UIView.animate(withDuration: animTime, animations:  {
                button.frame.size = CGSize(width: 0, height: widthVal)
                button.layer.cornerRadius = widthVal / 25
                button.center = CGPoint(x: xVal, y: yVal)
            })
            
            UIView.animate(withDuration: animTime, delay: animTime, animations: {
                button.frame.size = CGSize(width: widthVal, height: widthVal)
                button.layer.cornerRadius = widthVal / 2
                button.backgroundColor = baseColour
                button.center = CGPoint(x: xVal, y: yVal)
            })
        } else {
            UIView.animate(withDuration: animTime, animations:  {
                button.frame.size = CGSize(width: widthVal, height: 0)
                button.layer.cornerRadius = widthVal / 25
                button.center = CGPoint(x: xVal, y: yVal)
            })
            
            UIView.animate(withDuration: animTime, delay: animTime, animations: {
                button.frame.size = CGSize(width: widthVal, height: widthVal)
                button.layer.cornerRadius = widthVal / 2
                button.backgroundColor = baseColour
                button.center = CGPoint(x: xVal, y: yVal)
            })
        }
    }
    
    func updateFlipperDisplay() { // Updates the flipper based on the orientation
        if(FlipperOrientation == 0) {
            buttonFlipperCollection[3].backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 0)
            buttonFlipperCollection[5].backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 0)
            buttonFlipperCollection[1].backgroundColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
            buttonFlipperCollection[7].backgroundColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
            FlipperOrientation = 1
        } else {
            buttonFlipperCollection[1].backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 0)
            buttonFlipperCollection[7].backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 0)
            buttonFlipperCollection[3].backgroundColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
            buttonFlipperCollection[5].backgroundColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
            FlipperOrientation = 0
        }
    }
    
    func checkWin() -> Bool { // Checks if the win condition is met
        var WinTrue: Bool = true
        for CheckIndex in 0 ..< CurrentSequence.count {
            if (CurrentSequence[CheckIndex] != buttonStatus[CheckIndex]) {
                WinTrue = false
                break
            }
        }
        return WinTrue
    }
    
     // ********************************** SEGUES ********************************** //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameWonSegue" {
            // TODO: indicate if new record
            // TODO: indicate if new stage unlocked
            // TODO: help view
            
            if let vc = segue.destination as? WinScreenController {
                vc.game = self.game
                vc.ResetButtonsDelegateInstance = self
                vc.WinFlips = FlipCount
                vc.GoalFlips = GoalFlips
                vc.LevelNumber = LevelNum
            }
        } else if segue.identifier == "LoadLevelsSegue" {
            if let vc = segue.destination as? UINavigationController {
                let lvc = vc.children[0] as! LevelTableViewController
                lvc.game = self.game
                lvc.DisplayedStage = self.game?.currentStage ?? 0
                game!.UpdateLevelViewDelegateInstance = lvc
            }
        }
    }
}

 // ********************************** EXTENSIONS ********************************** //

extension MainViewController: ResetLevelDelegate {
    // Resets level to whatever the current level is
    func resetLevel() {
        UpdateModelDelegateInstance.requestLevel()
    }
}

extension MainViewController: UpdateMainViewDelegate { // Updates main view via model
    func receiveLevel(LevelID: Int, GoalFlips: Int16, Sequence: [Int], IsCompleted: Bool) {
        CurrentSequence = Sequence
        self.GoalFlips = GoalFlips
        LevelNum = LevelID
        levelCompleted = IsCompleted
        
        for winVal in 0 ..< CurrentSequence.count {
            if(CurrentSequence[winVal] == 0) {
                buttonWinCollection[winVal].backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
                // buttonWinCollection[winVal].layer.cornerRadius = buttonWinCollection[winVal].frame.size.width / 2
            } else {
                buttonWinCollection[winVal].backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
                // buttonWinCollection[winVal].layer.cornerRadius = buttonWinCollection[winVal].frame.size.width / 2
            }
        }
        levelTitle.text = "LEVEL \(LevelNum + 1)"
        resetButtons()
    }
}
