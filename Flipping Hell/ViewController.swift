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
    }
    
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
            flipperOrientation = 1
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
        
        flipNum += 1
        
        if (flipperOrientation == 0) {
            UIView.animate(withDuration: animTime, animations:  {
                button.frame.size = CGSize(width: 0, height: 50.0)
                button.layer.cornerRadius = 2
                button.center = CGPoint(x: xVal, y: yVal)
            })
            
            UIView.animate(withDuration: animTime, delay: animTime, animations: {
                button.frame.size = CGSize(width: 50.0, height: 50.0)
                button.layer.cornerRadius = 25
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
                button.layer.cornerRadius = 25
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
