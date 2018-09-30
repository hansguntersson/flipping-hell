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

    @IBAction func clickButton(_ sender: UIButton) {
        let button = sender
        let AnimTime = 0.35
        let xVal = button.center.x
        let yVal = button.center.y
        
        UIView.animate(withDuration: AnimTime, animations:  {
            button.frame.size = CGSize(width: 0, height: 50.0)
            button.layer.cornerRadius = 2
            button.backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
            button.center = CGPoint(x: xVal, y: yVal)
        })
        
        UIView.animate(withDuration: AnimTime, delay: AnimTime, animations: {
            button.frame.size = CGSize(width: 50, height: 50.0)
            button.layer.cornerRadius = 25
            button.backgroundColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
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
