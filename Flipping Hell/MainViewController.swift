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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateWinDisplay()
        
        buttonFlipperCollection[1].layer.cornerRadius = buttonFlipperCollection[1].frame.size.width / 2
        buttonFlipperCollection[3].layer.cornerRadius = buttonFlipperCollection[3].frame.size.width / 2
        buttonFlipperCollection[4].layer.cornerRadius = buttonFlipperCollection[4].frame.size.width / 2
        buttonFlipperCollection[5].layer.cornerRadius = buttonFlipperCollection[5].frame.size.width / 2
        buttonFlipperCollection[7].layer.cornerRadius = buttonFlipperCollection[7].frame.size.width / 2
        
        levelTitle.text = "LEVEL \(LevelNum)"
    }
    
    // ********************************** VARIABLES ********************************** //
    
    var GoalFlips = 0
    var FlipCount = 0
    var LevelNum = 0
    var FlipperOrientation = 0
    
    var buttonStatus = [0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0] // what the current status of the buttons is
    
    var currentLevel = [0, 0, 0, 0, 0,
                        0, 0, 1, 0, 0,
                        0, 1, 0, 1, 0,
                        0, 0, 1, 0, 0,
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
    
    var StarsString = "★"
    var StarsColour = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
    
    // ********************************** OUTLETS ********************************** //
    
    @IBOutlet var FlipsLabel: UILabel!
    @IBOutlet var levelTitle: UILabel!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var buttonWinCollection: [UIButton]!
    @IBOutlet var buttonFlipperCollection: [UIButton]!
    @IBOutlet var winScreen: UIView!
    
    var UpdateLevelsDelegate: UpdateLevelsScreenDelegate!
    
    // ********************************** FUNCTIONS ********************************** //
    
    @IBAction func backToLevelView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToMainViewController(segue:UIStoryboardSegue) {
        resetButtons()
    }
    
    @IBAction func resetLevel(_ sender: UIButton) {
        resetButtons()
    }
    
    func resetButtons() {
        // Reset flip and flipper
        FlipperOrientation = 1
        updateFlipperDisplay()
        FlipCount = 0
        
        // add 1 to attemps on the level if flips are greater than 0
        
        // Reset buttons and array
        for buttonIndex in 0 ..< buttonStatus.count {
            buttonStatus[buttonIndex] = 0
            buttonCollection[buttonIndex].backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        }
    }
    
    @IBAction func clickButton(_ sender: UIButton) {
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
            
            if (FlipCount - GoalFlips > 2) {
                StarsString = "★"
                StarsColour = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
            } else if (FlipCount - GoalFlips > 0) {
                StarsString = "★ ★"
                StarsColour = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else if (FlipCount - GoalFlips == 0) {
                StarsString = "★ ★ ★"
                StarsColour = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
            } else if (FlipCount - GoalFlips < 0) {
                StarsString = "✮ ✮ ✮"
                StarsColour = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            }
            
            UpdateLevelsDelegate.updateLevels(WinStars: StarsString, WinColour: StarsColour, WinFlips: FlipCount)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.performSegue(withIdentifier: "GameWonSegue", sender: self)
            }
        }
    }
    
    func updateWinDisplay() {
        for winVal in 0 ..< currentLevel.count {
            if(currentLevel[winVal] == 0) {
                buttonWinCollection[winVal].backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
                buttonWinCollection[winVal].layer.cornerRadius = buttonWinCollection[winVal].frame.size.width / 2
            } else {
                buttonWinCollection[winVal].backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
                buttonWinCollection[winVal].layer.cornerRadius = buttonWinCollection[winVal].frame.size.width / 2
            }
        }
    }
    
    func updateFlipperDisplay() {
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
    
    func flipButton(_ sender: UIButton, buttonIndex: Int) {
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
    
    func checkWin() -> Bool {
        var WinTrue: Bool = true
        for CheckIndex in 0 ..< currentLevel.count {
            if (currentLevel[CheckIndex] != buttonStatus[CheckIndex]) {
                WinTrue = false
                break
            }
        }
        return WinTrue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? WinScreenController {
            vc.ResetButtonsDelegate = self
            vc.WinFlipsString = "FLIPS: \(FlipCount)"
            vc.GoalFlipsString = "GOAL: \(GoalFlips)"
            vc.WinStarsString = StarsString
            vc.WinStarColor = StarsColour
        }
    }
    
}

 // ********************************** EXTENSIONS ********************************** //

extension MainViewController: ResetDelegate {
    func resetToLevel(NextLevel: Bool) {
        if(NextLevel == false) {
            resetButtons()
            print("Reset this level")
        } else if(NextLevel == true) {
            resetButtons()
            // move to the next level
            print("Reset next level")
        } else {
            print("Delegate error on resetting function")
        }
    }
}
