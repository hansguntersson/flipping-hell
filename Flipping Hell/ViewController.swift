//
//  ViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 20/09/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flipNum = 0
    
    var buttonStatus = [0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0,
                        0, 0, 0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBOutlet weak var flipCount: UILabel!

    @IBAction func clickButton(_ sender: UIButton) {
        let button = sender
        let animTime = 0.2
        let xVal = button.center.x
        let yVal = button.center.y
        var baseColour = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        
        let idNum = Int(button.accessibilityIdentifier ?? "0")
        
        let buttonIndex = buttonStatus[idNum!]
        
        if(buttonIndex == 0) {
            baseColour = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
            buttonStatus[idNum!] = 1
        } else {
            baseColour = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
            buttonStatus[idNum!] = 0
        }
        
        flipNum += 1
        flipCount.text = "FLIPS: \(flipNum)"
        
        UIView.animate(withDuration: animTime, animations:  {
            button.frame.size = CGSize(width: 0, height: 50.0)
            button.layer.cornerRadius = 2
            // button.backgroundColor = baseColour
            button.center = CGPoint(x: xVal, y: yVal)
        })
        
        UIView.animate(withDuration: animTime, delay: animTime, animations: {
            button.frame.size = CGSize(width: 50, height: 50.0)
            button.layer.cornerRadius = 25
            button.backgroundColor = baseColour
            button.center = CGPoint(x: xVal, y: yVal)
        })
        
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
