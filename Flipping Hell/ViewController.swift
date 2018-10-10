//
//  ViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 20/09/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateWinDisplay()
        
        buttonFlipperCollection[1].layer.cornerRadius = buttonFlipperCollection[1].frame.size.width / 2
        buttonFlipperCollection[3].layer.cornerRadius = buttonFlipperCollection[3].frame.size.width / 2
        buttonFlipperCollection[4].layer.cornerRadius = buttonFlipperCollection[4].frame.size.width / 2
        buttonFlipperCollection[5].layer.cornerRadius = buttonFlipperCollection[5].frame.size.width / 2
        buttonFlipperCollection[7].layer.cornerRadius = buttonFlipperCollection[7].frame.size.width / 2
    }
    
    // var game = FlippingHell()
    // Need to move functions to model from view controller and also update the view from the model
    
    var flipNum = 0 {
        didSet {
            flipCount.text = "FLIPS: \(flipNum)"
        }
    }
    
    var flipperOrientation = 0
    
    var buttonStatus = [0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0]
    
    var currentLevel = [0, 0, 0, 0, 0,
                        0, 0, 1, 0, 0,
                        0, 1, 0, 1, 0,
                        0, 0, 1, 0, 0,
                        0, 0, 0, 0, 0]
    
    var leftValidNums = [1, 2, 3, 4,
                         6, 7, 8, 9,
                         11, 12, 13, 14,
                         16, 17, 18, 19,
                         21, 22, 23, 24]
    
    var rightValidNums = [0, 1, 2, 3,
                          5, 6, 7, 8,
                          10, 11, 12, 13,
                          15, 16, 17, 18,
                          20, 21, 22, 23]
    
    
    @IBOutlet weak var flipCount: UILabel!
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet var buttonWinCollection: [UIButton]!
    @IBOutlet var buttonFlipperCollection: [UIButton]!
    
    
    
    @IBAction func clickButton(_ sender: UIButton) {
        let button = sender
        
        let idNum = Int(button.accessibilityIdentifier ?? "0")
        
        flipButton(button, buttonIndex: idNum!)

        if (flipperOrientation == 0) {
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
            updateFlipperDisplay()
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
            updateFlipperDisplay()
        }
        flipNum += 1
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
        
        
        
        if(flipperOrientation == 0) {
            buttonFlipperCollection[3].backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 0)
            buttonFlipperCollection[5].backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 0)
            buttonFlipperCollection[1].backgroundColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
            buttonFlipperCollection[7].backgroundColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
            flipperOrientation = 1
        } else {
            buttonFlipperCollection[1].backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 0)
            buttonFlipperCollection[7].backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 0)
            buttonFlipperCollection[3].backgroundColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
            buttonFlipperCollection[5].backgroundColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
            flipperOrientation = 0
        }
    }
    
    
    func flipButton(_ sender: UIButton, buttonIndex: Int) {
        let button = sender
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
        
        if (flipperOrientation == 0) {
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
}


@IBDesignable extension UIButton {
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
