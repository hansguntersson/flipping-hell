//
//  MainViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 20/09/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

// ********************************** PROTOCOLS ********************************** //

protocol UpdateLevelsScreenDelegate {
    func updateLevels(WinStars: String, WinColour: UIColor, WinFlips: Int)
}

// ********************************** CLASS DEFINITION ********************************** //

class MainViewController: UIViewController {
    
    // ********************************** VARIABLES ********************************** //
    
    var game = FlippingHell()
    
    var GoalFlips = 0
    var FlipCount = 0
    var LevelNum = 0
    var StageNum = 0
    var FlipperOrientation = 0
    
    var buttonStatus = [0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0] // what the current status of the buttons is
    
    var CurrentLevel = [0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0] // The level array loaded
    
    var leftValidNums = [1, 2, 3, 4,
                         6, 7, 8, 9,
                         11, 12, 13, 14,
                         16, 17, 18, 19,
                         21, 22, 23, 24] // List to define when left button is flipped
    
    var rightValidNums = [0, 1, 2, 3,
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
    
    var UpdateLevelsDelegate: UpdateLevelsScreenDelegate!
    
    
    // ********************************** FUNCTIONS ********************************** //
    
    func loadLevel(levelToLoad: Int) { // Loads level, updates win display and title
        CurrentLevel = game.levels[levelToLoad].sequence
        GoalFlips = game.levels[levelToLoad].GoalFlips
        LevelNum = levelToLoad
        
        for winVal in 0 ..< CurrentLevel.count {
            if(CurrentLevel[winVal] == 0) {
                buttonWinCollection[winVal].backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
                buttonWinCollection[winVal].layer.cornerRadius = buttonWinCollection[winVal].frame.size.width / 2
            } else {
                buttonWinCollection[winVal].backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
                buttonWinCollection[winVal].layer.cornerRadius = buttonWinCollection[winVal].frame.size.width / 2
            }
        }
        levelTitle.text = "LEVEL \(LevelNum + 1)"
    }
    
    
    @IBAction func backToMain(_ sender: UIButton) { // Dismisses view controller back to the title screen
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetLevel(_ sender: UIButton) { //Resets the level from the main screen
        resetButtons()
    }
    
    
    override func viewDidLoad() { // Sets up game on load
        super.viewDidLoad()
        // game.LevelStages.loadLevels()
        // Do any additional setup after loading the view, typically from a nib.
        
        buttonFlipperCollection[1].layer.cornerRadius = buttonFlipperCollection[1].frame.size.width / 2
        buttonFlipperCollection[3].layer.cornerRadius = buttonFlipperCollection[3].frame.size.width / 2
        buttonFlipperCollection[4].layer.cornerRadius = buttonFlipperCollection[4].frame.size.width / 2
        buttonFlipperCollection[5].layer.cornerRadius = buttonFlipperCollection[5].frame.size.width / 2
        buttonFlipperCollection[7].layer.cornerRadius = buttonFlipperCollection[7].frame.size.width / 2
        
        loadLevel(levelToLoad: 0)
        
        // Can use the following functionality for sizing:
        // buttonClassID.layer.cornerRadius = buttonClassID.frame.size.height/2
    }
    
    func resetButtons() { // Resets buttons
        // Reset flip and flipper
        FlipperOrientation = 1
        updateFlipperDisplay()
        FlipCount = 0
        FlipsLabel.text = "FLIPS: \(FlipCount)"
        
        // add 1 to attemps on the level if flips are greater than 0
        
        // Reset buttons and array
        for buttonIndex in 0 ..< buttonStatus.count {
            buttonStatus[buttonIndex] = 0
            buttonCollection[buttonIndex].backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        }
    }
    
    @IBAction func clickButton(_ sender: UIButton) { // Flips buttons based on the button clicked
        let button = sender
        var WinVal = false
        
        let idNum = Int(button.accessibilityIdentifier ?? "0")
        
        flipButton(button, buttonIndex: idNum!)

        if (FlipperOrientation == 0) {
            if (leftValidNums.contains(idNum!)) {
                let idNumLeft = idNum! - 1
                let buttonLeft = buttonCollection[idNumLeft]
                flipButton(buttonLeft, buttonIndex: idNumLeft)
            }
            if (rightValidNums.contains(idNum!)) {
                let idNumRight = idNum! + 1
                let buttonRight = buttonCollection[idNumRight]
                flipButton(buttonRight, buttonIndex: idNumRight)
            }
        } else {
            if (idNum! > 4) {
                let idNumTop = idNum! - 5
                let buttonTop = buttonCollection[idNumTop]
                flipButton(buttonTop, buttonIndex: idNumTop)
            }
            if (idNum! < 20) {
                let idNumBottom = idNum! + 5
                let buttonBottom = buttonCollection[idNumBottom]
                flipButton(buttonBottom, buttonIndex: idNumBottom)
            }
        }
        updateFlipperDisplay()
        FlipCount += 1
        FlipsLabel.text = "FLIPS: \(FlipCount)"
        
        WinVal = checkWin()
        
        if (WinVal == true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.performSegue(withIdentifier: "GameWonSegue", sender: self)
            }
        }
    }
    
    func flipButton(_ sender: UIButton, buttonIndex: Int) { // Flips the corresponding button
        let button = sender
        let animTime = 0.2
        let xVal = button.center.x
        let yVal = button.center.y
        var baseColour = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        
        let buttonState = buttonStatus[buttonIndex]
        
        // THIS IS THE GAME BIT WE NEED TO MOVE TO THE MODEL
        
        if (buttonState == 0) {
            baseColour = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
            buttonStatus[buttonIndex] = 1
        } else {
            baseColour = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
            buttonStatus[buttonIndex] = 0
        }
        
        if (FlipperOrientation == 0) {
            UIView.animate(withDuration: animTime, animations:  {
                button.frame.size = CGSize(width: 0, height: 50.0)
                button.layer.cornerRadius = 2
                button.center = CGPoint(x: xVal, y: yVal)
            })
            
            UIView.animate(withDuration: animTime, delay: animTime, animations: {
                button.frame.size = CGSize(width: 50.0, height: 50.0)
                button.layer.cornerRadius = button.frame.size.width / 2
                button.backgroundColor = baseColour
                button.center = CGPoint(x: xVal, y: yVal)
            })
        } else {
            UIView.animate(withDuration: animTime, animations:  {
                button.frame.size = CGSize(width: 50.0, height: 0)
                button.layer.cornerRadius = 2
                button.center = CGPoint(x: xVal, y: yVal)
            })
            
            UIView.animate(withDuration: animTime, delay: animTime, animations: {
                button.frame.size = CGSize(width: 50.0, height: 50.0)
                button.layer.cornerRadius = button.frame.size.width / 2
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
        for CheckIndex in 0 ..< CurrentLevel.count {
            if (CurrentLevel[CheckIndex] != buttonStatus[CheckIndex]) {
                WinTrue = false
                break
            }
        }
        return WinTrue
    }
    
     // ********************************** SEGUES ********************************** //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameWonSegue" {
            if let vc = segue.destination as? WinScreenController {
                vc.ResetButtonsDelegate = self
                vc.WinFlips = FlipCount
                vc.GoalFlips = GoalFlips
                vc.LevelNumber = LevelNum
            }
        } else if segue.identifier == "LoadLevelsSegue" {
            if let vc = segue.destination as? UINavigationController {
                let lvc = vc.children[0] as! LevelTableViewController
                lvc.levels = game.levels
            }
        } else if segue.identifier == "loadOptionsSegue" {
            print("Options Segue")
        } else if segue.identifier == "loadAboutSegue" {
            print("About Segue")
        }
    }
    
    @IBAction func unwindfromLevel(sender: UIStoryboardSegue) {
        resetButtons()
        loadLevel(levelToLoad: 5)
    }
    
}

 // ********************************** EXTENSIONS ********************************** //

extension MainViewController: ResetDelegate { // Resets level to current or next level
    func resetToLevel(Level: Int) {
            resetButtons()
            loadLevel(levelToLoad: Level)
    }
}
