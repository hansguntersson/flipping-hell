//
//  GameViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 06/12/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

// ********************************** CLASS DEFINITION ********************************** //

class GameViewController: UIViewController {
    
    var game = FlippingHell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let CD_testid: Int32 = 5
        // slet CD_flips: Int16 = 10
        
        // save(testid: CD_testid, flips: CD_flips)
        
        // Do any additional setup after loading the view.
        
        // save(testid: Int32, flips: Int16)
        
    }
    
    // ********************************** FUNCTIONS ********************************** //

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "GameStartSegue" {
            if let vc = segue.destination as? MainViewController {
                vc.game = self.game
                game.UpdateMainViewDelegateInstance = vc
            }
        } else if segue.identifier == "loadOptionsSegue" {
            print("Options Segue")
        } else if segue.identifier == "loadAboutSegue" {
            print("About Segue")
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

@IBDesignable extension UIView {
    @IBInspectable var cornerRadiusVIEW: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
}
